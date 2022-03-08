Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5884D2384
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Mar 2022 22:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbiCHVpf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Mar 2022 16:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbiCHVpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Mar 2022 16:45:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1A4D25D
        for <linux-nfs@vger.kernel.org>; Tue,  8 Mar 2022 13:44:37 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 35F354B53; Tue,  8 Mar 2022 16:44:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 35F354B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646775877;
        bh=LMblVJNZM1SsTP0rXRBEEG3hXbkUoxGHnxaWHCQg7+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baNJnUK5quyNXxLjwzSUOMqZozaFq9ryKlfd/0kl8QhffUwTZBOsOyWc/ichpJoz6
         sr94IqOBlm28/nuz/qJSNJ8I7fBbY4zewzmx4FmDM1oX9kAeWlSjrXTMGivKlh3r1U
         parYr+DTiNoz5SSloQGgFqmjUYmw8faw2jpaNeVA=
Date:   Tue, 8 Mar 2022 16:44:37 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, david@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com
Subject: Re: [RFC PATCH 1/6] Implement reexport helper library
Message-ID: <20220308214437.GB22644@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217131531.2890-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217131531.2890-2-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 17, 2022 at 02:15:26PM +0100, Richard Weinberger wrote:
> +#define REEXPDB_SHM_NAME "/nfs_reexport_db_lock"
> +#define REEXPDB_SHM_SZ 4096
> +#define REEXPDB_INIT_LOCK NFS_STATEDIR "/reexpdb_init.lock"
> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"

I don't know much about sqlite--why do we need to do our own file
locking?  If we do need to do it ourself, could we lock the database
file instead instead of using a separate lock file?

> +static const char initdb_sql[] = "CREATE TABLE IF NOT EXISTS fsidnums (num INTEGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE); CREATE TABLE IF NOT EXISTS subvolumes (path TEXT PRIMARY KEY); CREATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);";

I'd personally find it easier to read if these were defined in the place
where they're used.  (And, honestly, if this is just used once, maybe
the definition is unnecessary.)

What are the two tables used for?  Naively I'd've thought the
"subvolumes" table was redundant.

> +/*
> + * This query is a little tricky. We use SQL to find and claim the smallest free fsid number.

Yes, that is a little tricky.  Is it necessary?  My SQL Is rusty, but
the database should be able to pick a unique value for us, shouldn't it?

> + * To find a free fsid the fsidnums is left joined to itself but with an offset of 1.
> + * Everything after the UNION statement is to handle the corner case where fsidnums
> + * is empty. In this case we want 1 as first fsid number.
> + */
> +static const char new_fsidnum_by_path_sql[] = "INSERT INTO fsidnums VALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS ids2 ON ids2.num = ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHERE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num = 1) LIMIT 1), ?1) RETURNING num;";
> +static const char fsidnum_by_path_sql[] = "SELECT num FROM fsidnums WHERE path = ?1;";
> +static const char add_crossed_volume_sql[] = "REPLACE INTO subvolumes VALUES(?1);";
> +static const char drop_crossed_volume_sql[] = "DELETE FROM subvolumes WHERE path = ?1;";
> +static const char get_crossed_volumes_sql[] = "SELECT path from subvolumes;";
...
> +/*
> + * reexpdb_init - Initialize reexport database
> + *
> + * Setup shared lock (database is concurrently used by multiple processes),

So, this should all work when rpc.mountd is run with --num_threads > 1?

--b.

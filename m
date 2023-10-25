Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AD7D6F77
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjJYOWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJYOV7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 10:21:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339E99;
        Wed, 25 Oct 2023 07:21:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A60421BB5;
        Wed, 25 Oct 2023 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698243715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6m+wqEMlZRmmaiTawtcjDnjRXGd+ey2+AQbrwr0QEjw=;
        b=Zk6vu6DDY+yiUE2kKCcR5WHyZ6o2I/EGaNp5h+wXK9fjG5RnNRwIHmRzXe5Q/ffYBo/mTk
        qguxulYcwWRaKL2yg1UNfhgpqClYn80FvCkAWvzt/QVDlP0UiezNfZImCTr8dkhnGf4rgq
        t+gSva6X2gDmKBdWUBiDPxvKKxMy1AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698243715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6m+wqEMlZRmmaiTawtcjDnjRXGd+ey2+AQbrwr0QEjw=;
        b=EtTVcikI8IWcHOjnCmdbzjetspIvRIPNXk5rUVrXAMuQy9oZfHZ56OcVWs8k9eeFrL/MmK
        sQt4Wg6fg02XCsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 697DB138E9;
        Wed, 25 Oct 2023 14:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q0EqGYMkOWXhGgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:21:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F29D1A0679; Wed, 25 Oct 2023 16:21:54 +0200 (CEST)
Date:   Wed, 25 Oct 2023 16:21:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fuse: derive f_fsid from s_dev and connection start time
Message-ID: <20231025142154.witld2g5iici24fr@quack3>
References: <20231025114228.23167-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025114228.23167-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.58
X-Spamd-Result: default: False [-6.58 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.98)[99.92%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 25-10-23 14:42:28, Amir Goldstein wrote:
> Use s_dev number and connection start time to report f_fsid in statfs(2).
> 
> The s_dev number could be easily recycled, so we use lower 32bits of the
> connection start time to try to avoid the recycling of f_fsid.
> The anon bdev number is only 20 bits (major is 0), so we could use more
> bits from connection start time, but avoiding f_fsid recycling is not
> critical, so 32bit is enough.
> 
> If the server does not support NFS export, fuse client still advertizes
> ->s_export_op, but those are non compliant operations that often cannot
> decode file handles, or worse, decode file hanldes to wrong objects.
> 
> In this case, leave f_fsid zero to signal fanotify and aware users to
> avoid exporting this incompliant fuse filesystem to NFS.
> 
> This allows fuse client to be monitored by fanotify filesystem watch
> for local client file access if server supports NFS export.
> 
> For example, with inotify-tools 4.23.8.0, the following command can be
> used to watch local client access over entire nfs filesystem:
> 
>   fsnotifywatch --filesystem /mnt/fuse
> 
> Note that fanotify filesystem watch does not report remote changes on
> server.  It provides the same notifications as inotify, but it watches
> over the entire filesystem and reports file handle of objects and fsid
> with events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> I'd like to explain why I chose to tie setting fuse f_fsid with fuse
> server NFS export capability.
> 
> Since v6.6-rc7, fanotify permits sb/mount watch only for filesystems
> that know how to decode ALL file handles (not only how to encode).
> fanotify checks for the ->fh_to_dentry() method, which fuse always
> implements regardless of server NFS export support.
> 
> At first I considered assigning s_export_op depending on server NFS
> export support, but that would break the exising fuse best-effort decode
> behavior, whatever it is worth.
> 
> Currently, fanotify sb watch does not support fuse because of zero f_fsid,
> so I decided to keep it this way for the incomplete NFS export case.

OK, so this will keep fanotify not able to support inotify functionality in
this corner case. I'm fine with that but I'm making sure I understand the
implications.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

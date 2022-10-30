Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A6612D19
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 22:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ3Vpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Vpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 17:45:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23315A190
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 14:45:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCEB320FBB;
        Sun, 30 Oct 2022 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667166329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPDvJO3PV29L332LrBBfBTWW1dvNUf+YfLIX81rWwAo=;
        b=ZFmWK1/mDnewTv3EcMeJT6sOZt+EWbsJdHCoLvG9hXAiuBsGu4bAvAZRkei0PD8OvTj2xO
        Bt6e8FhDEuMvi9ALVyK/3d4Z7JcrX8svzTQ7U7rJLYCvrlOUavUdUzyFYqvtfz+bcvSXpF
        Vn8UibZ4Svjq8Lp4x/wr8KDdY6MnIIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667166329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPDvJO3PV29L332LrBBfBTWW1dvNUf+YfLIX81rWwAo=;
        b=9jMhHaNgWEEJnaZz+hVvl4R0Mf/3oYoxhYx7XbIPAAnL3H1HyjNOeW4qoOw/r7av5u0F4i
        o8r7ztcKLdbSHwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4FC813A37;
        Sun, 30 Oct 2022 21:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fz5sF3jwXmP/PQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Oct 2022 21:45:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU addition
In-reply-to: <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>,
 <20221028185712.79863-4-jlayton@kernel.org>,
 <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
Date:   Mon, 31 Oct 2022 08:45:09 +1100
Message-id: <166716630911.13915.14442550645061536898@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 29 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > The list_lru_add and list_lru_del functions use list_empty checks to see
> > whether the object is already on the LRU. That's fine in most cases, but
> > we occasionally repurpose nf_lru after unhashing. It's possible for an
> > LRU removal to remove it from a different list altogether if we lose a
> > race.
> 
> I've never seen that happen. lru field re-use is actually used in other
> places in the kernel. Shouldn't we try to find and fix such races?
> 
> Wasn't the idea to reduce the complexity of nfsd_file_put ?
> 

I think the nfsd filecache is different from those "other places"
because of nfsd_file_close_inode() and related code.  If I understand
correctly, nfsd can remove a file from the filecache while it is still
in use.  In this case it needs to be unhashed and removed from the lru -
and then added to a dispose list - while it might still be active for
some IO request.

Prior to Commit 8d0d254b15cc ("nfsd: fix nfsd_file_unhash_and_dispose")
unhash_and_dispose() wouldn't add to the dispose list unless the
refcount was one.  I'm not sure how racy this test was, but it would
mean that it is unlikely for an nfsd_file to be added to the dispose list
if it was still in use.

After that commit it seems more likely that a nfsd_file will be added to
a dispose list while it is in use.
As we add/remove things to a dispose list without a lock, we need to be
careful that no other thread will add the nfsd_file to an lru at the
same time.  refcounts will no longer provide that protection.  Maybe we
should restore the refcount protection, or maybe we need a bit as Jeff
has added here.

NeilBrown

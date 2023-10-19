Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16517CFC5F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjJSOXD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjJSOXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 10:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1213A;
        Thu, 19 Oct 2023 07:22:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52EEC21A48;
        Thu, 19 Oct 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697725378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4E7Btm1jA8tM6Dk6HYd/aVW7uwFxHG0gM68WS0p6SfM=;
        b=oErc7CHRqi9w0L2wHrNP8sqxdgLBFhlmZqElAvjHfsI/8ywickv3XzqEJERXlGN0qsGPQU
        Wra/GiXwRbieXPcBINAK/TqbLXeqM154zuP2Sq5fkDefdBCL9S86j5rqgK6uxk6MfwDTj8
        VxfM8BATKRAxlXmopmCAk1iJdkyVLx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697725378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4E7Btm1jA8tM6Dk6HYd/aVW7uwFxHG0gM68WS0p6SfM=;
        b=9fXmjegVRRCulgG3AJ6e71pr181SScpKn6DyMu9rZWyDeMayPdzl/m6Tn0/+N/MO+9j5OF
        rFiZ/oLHm4aYNiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A60B139C2;
        Thu, 19 Oct 2023 14:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dz0+DsI7MWVxfQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 14:22:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7831EA06B0; Thu, 19 Oct 2023 16:22:57 +0200 (CEST)
Date:   Thu, 19 Oct 2023 16:22:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/5] fanotify: limit reporting of event with
 non-decodeable file handles
Message-ID: <20231019142257.yevkf7i2istyzen2@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-2-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
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
         RCPT_COUNT_SEVEN(0.00)[7];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 18-10-23 12:59:56, Amir Goldstein wrote:
> Commit a95aef69a740 ("fanotify: support reporting non-decodeable file
> handles") merged in v6.5-rc1, added the ability to use an fanotify group
> with FAN_REPORT_FID mode to watch filesystems that do not support nfs
> export, but do know how to encode non-decodeable file handles, with the
> newly introduced AT_HANDLE_FID flag.
> 
> At the time that this commit was merged, there were no filesystems
> in-tree with those traits.
> 
> Commit 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles"),
> merged in v6.6-rc1, added this trait to overlayfs, thus allowing fanotify
> watching of overlayfs with FAN_REPORT_FID mode.
> 
> In retrospect, allowing an fanotify filesystem/mount mark on such
> filesystem in FAN_REPORT_FID mode will result in getting events with
> file handles, without the ability to resolve the filesystem objects from
> those file handles (i.e. no open_by_handle_at() support).
> 
> For v6.6, the safer option would be to allow this mode for inode marks
> only, where the caller has the opportunity to use name_to_handle_at() at
> the time of setting the mark. In the future we can revise this decision.
> 
> Fixes: a95aef69a740 ("fanotify: support reporting non-decodeable file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

OK, I agree sb/mount marks reporting FIDs are hardly usable without
name_to_handle_at() so better forbid them before someone comes up with some
creative abuse. I've queued the patch into my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f69c451018e3..537c70beaad0 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1585,16 +1585,25 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
>  }
>  
>  /* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct dentry *dentry)
> +static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
>  {
> +	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +	const struct export_operations *nop = dentry->d_sb->s_export_op;
> +
> +	/*
> +	 * We need to make sure that the filesystem supports encoding of
> +	 * file handles so user can use name_to_handle_at() to compare fids
> +	 * reported with events to the file handle of watched objects.
> +	 */
> +	if (!nop)
> +		return -EOPNOTSUPP;
> +
>  	/*
> -	 * We need to make sure that the file system supports at least
> -	 * encoding a file handle so user can use name_to_handle_at() to
> -	 * compare fid returned with event to the file handle of watched
> -	 * objects. However, even the relaxed AT_HANDLE_FID flag requires
> -	 * at least empty export_operations for ecoding unique file ids.
> +	 * For sb/mount mark, we also need to make sure that the filesystem
> +	 * supports decoding file handles, so user has a way to map back the
> +	 * reported fids to filesystem objects.
>  	 */
> -	if (!dentry->d_sb->s_export_op)
> +	if (mark_type != FAN_MARK_INODE && !nop->fh_to_dentry)
>  		return -EOPNOTSUPP;
>  
>  	return 0;
> @@ -1812,7 +1821,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		if (ret)
>  			goto path_put_and_out;
>  
> -		ret = fanotify_test_fid(path.dentry);
> +		ret = fanotify_test_fid(path.dentry, flags);
>  		if (ret)
>  			goto path_put_and_out;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

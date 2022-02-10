Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F944B143F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiBJRcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 12:32:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBJRcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 12:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066E82647
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644514327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKFnzr3mw42+cLmY82j9IW2wooukdLwJVlZhUwWFhlU=;
        b=WN8J50J0+S9InL8ZaZLNZei8pc2ICgoL0v7uynNFWJb872K7MwwXmTXxlXMtGHh0iVowoz
        /ITgr4MI5Acp6xmh5L+Fgi/+Y58FXO/E4bLeLDEJ7eDoHhoXCdT8QZRbQHSdg9HuPWG3L3
        l9l45p4PrKgl1FsRN7OwTbV34KaYAzg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-GpT7EPG4PCS_ETzP19_Kbg-1; Thu, 10 Feb 2022 12:32:03 -0500
X-MC-Unique: GpT7EPG4PCS_ETzP19_Kbg-1
Received: by mail-qt1-f200.google.com with SMTP id j30-20020ac84c9e000000b002cf986622d1so4934500qtv.6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gKFnzr3mw42+cLmY82j9IW2wooukdLwJVlZhUwWFhlU=;
        b=4TM0Sk0qurUF82S+zN8CqpBqMcWxqPto8+z2Y5To235tQh5Esx0Vr7Trb9Y7vVwOCr
         4T8SkdJ9osjQTfAh8F0Uyud0YdHIAGzkvDVZyF87xm3mknwVs+MCmH0t+GD6ryOvgR+K
         nHogQ9r0m0iro+J8glibAPgscZF7iEZVW18r+Ar/Ph7kNC8YGkmoWcxEyT+OhcquTtPt
         gs1EnyHANZTQQ9b9pliEKRl7ehYVybYmtax5hjfyU6C5LOBzrshn4cRh5ysdtPUIdi6P
         uNdgSu/C/W/0RNCrPwKLEFLLIhAgq80C5/AGaSN5P4R396E5LtyCUmqxJAVpv6DYTJx7
         pypw==
X-Gm-Message-State: AOAM531mvMmUkK4oc0qZ0Z2W8gDsy6xzPvP23XKVx+AHQRQr8XK6MAFc
        YmBSAdzSuDxwOsG0aoxIOZBM9kj80wiCa+u7OZY6uFRrg8gnzEPLmH5LnOkd4Wablmw6wSA68Hz
        E5xRnxcCl+dILTKNZyj6p
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr5570350qtx.278.1644514323456;
        Thu, 10 Feb 2022 09:32:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz24bjw/li4d++11Tr6sKRRTIK+JHKdr4CaSbu5BNNRZFHqf2AlI0qo+B+Zlp3w3EvzXsJumQ==
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr5570332qtx.278.1644514323208;
        Thu, 10 Feb 2022 09:32:03 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id bk23sm10146791qkb.3.2022.02.10.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:32:02 -0800 (PST)
Message-ID: <76dbd9cebe142067b9322d66c23f9b77f8075cf0.camel@redhat.com>
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback,
 lm_lock_conflict, to lock_manager_operations
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 10 Feb 2022 12:32:02 -0500
In-Reply-To: <2AEF8E7D-2F4E-4D88-8B71-48195C6E45ED@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
         <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
         <20220210142826.GD21434@fieldses.org>
         <2AEF8E7D-2F4E-4D88-8B71-48195C6E45ED@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-02-10 at 16:50 +0000, Chuck Lever III wrote:
> 
> > On Feb 10, 2022, at 9:28 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index bbf812ce89a8..726d0005e32f 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1068,6 +1068,14 @@ struct lock_manager_operations {
> > > 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> > > 	void (*lm_setup)(struct file_lock *, void **);
> > > 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > > +	/*
> > > +	 * This callback function is called after a lock conflict is
> > > +	 * detected. This allows the lock manager of the lock that
> > > +	 * causes the conflict to see if the conflict can be resolved
> > > +	 * somehow. If it can then this callback returns false; the
> > > +	 * conflict was resolved, else returns true.
> > > +	 */
> > > +	bool (*lm_lock_conflict)(struct file_lock *cfl);
> > > };
> > 
> > I don't love that name.  The function isn't checking for a lock
> > conflict--it'd have to know *what* the lock is conflicting with.  It's
> > being told whether the lock is still valid.
> > 
> > I'd prefer lm_lock_expired(), with the opposite return values.
> 
> Or even lm_lock_is_expired(). I agree that the sense of the
> return values should be reversed.
> 
> 
> The block comment does not belong in struct lock_manager_operations,
> IMO.
> 
> Jeff's previous review comment was:
> 
> > > @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > > 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > > 			if (!posix_locks_conflict(request, fl))
> > > 				continue;
> > > +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
> > > +				!fl->fl_lmops->lm_lock_conflict(fl))
> > > +				continue;
> > 
> > The naming of this op is a little misleading. We already know that there
> > is a lock confict in this case. The question is whether it's resolvable
> > by expiring a tardy client. That said, I don't have a better name to
> > suggest at the moment.
> > 
> > A comment about what this function actually tells us would be nice here.
> 
> 
> I agree that a comment that spells out the API contract would be
> useful. But it doesn't belong in the middle of struct
> lock_manager_operations, IMO.
> 
> I usually put such information in the block comment that precedes
> the individual functions (nfsd4_fl_lock_conflict in this case).
> 
> Even so, the patch description has this information already.
> Jeff, I think the patch description is adequate for this
> purpose -- more information appears later in 3/3. What do you
> think?
> 

I'd be fine with that.
-- 
Jeff Layton <jlayton@redhat.com>


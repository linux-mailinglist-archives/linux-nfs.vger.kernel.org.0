Return-Path: <linux-nfs+bounces-2385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4287F68E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 06:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3053E281AF2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 05:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3F40853;
	Tue, 19 Mar 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUPjGV+d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WH/UwhdG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iOCN3knu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YJw2p8gg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457F40840
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710825159; cv=none; b=NHgMiZq6M6xCCJV7kandIPA+SYkd/iebQuhleUJON/yyaYQw5wlhQ0H0rFxs6Buv338NlJwDs8qruNbKqpPXmznCnc79MvLBsb83hTuLqJ5bi3bwYigQ8mzEVw/YJ8zqr+643fEfOz8649tVdqOPC2RDBV/JANN9RRyHJ5kwjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710825159; c=relaxed/simple;
	bh=9N+O9zkq5bYhnqzNw5Mr8Q5WrtysrSaSo3Fk+EoE1K8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=S4mN0N5hZ3LTadV69yl4tmaWk9gVs3RDDald+bdXC7YEjo3D1rmYss1zrSCPPGkMP+cPe9v2vBoootOobA0X+lKWb1RBunESITi7lwRXJVdVAajRJcNYG4F2ax2p5ef/4Ms6+jwMYtqTdtMHthZRMXggxZ5LgaPDoE4vZy9Jcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUPjGV+d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WH/UwhdG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iOCN3knu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YJw2p8gg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7B525D0C3;
	Tue, 19 Mar 2024 05:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710825155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk291jOQDFbqqfgUOsmV5g5fxvTG/tmIiJZssWkcN8k=;
	b=WUPjGV+dPIiujYn/NiEeJ5KoFTrm8sZONh/LzRVaCega7Wbro0NjgOOSHYn2ZrgoRItQHD
	3fwVlgUV4wGWBhNpILaTuYRaQ5bEcp2HfoVVGSEI1YxQSp2rIkmpqCw1eKrOlRJ61Sy0UR
	0Jy9rCpjNc+03X92oI1ETmi+vzqCpGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710825155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk291jOQDFbqqfgUOsmV5g5fxvTG/tmIiJZssWkcN8k=;
	b=WH/UwhdGa4h74QQG7rWX4Y45w2GQenQUjYJ19rrKUNPyjralJetf5WApu8C2dUXweuJfv/
	Ql5fRSnDz10A/iCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710825154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk291jOQDFbqqfgUOsmV5g5fxvTG/tmIiJZssWkcN8k=;
	b=iOCN3knuEjBj3/XLSpnTSaW2pr1O2J22UV3JB+T748gB+Fxrall3GvyqPuCsG6IEnsmBnW
	3WMn3kJhifCN+asL/zInlszSTKryHxUOZWYglFjcwBdWEpg5YCvxFi+XqAzJPDQ/ADnVCy
	a1gkstVGC7wjDPJrYznDKG7kL6QWDpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710825154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk291jOQDFbqqfgUOsmV5g5fxvTG/tmIiJZssWkcN8k=;
	b=YJw2p8ggfcUQNTJtVFw8zFqKPhHWsXnhU/IKAJG8l88YnfaB4wBQl+xIR/l6FdkW+Zlvmq
	mKYsza77UKrlj1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64609136A5;
	Tue, 19 Mar 2024 05:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g6oQAsEe+WU7QgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Mar 2024 05:12:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject:
 Re: Question about possible use-after-free in nfs_direct_write_reschedule()
In-reply-to: <02300d56202423fc7277b0ee923b40f00d4903db.camel@hammerspace.com>
References: <171080858885.13576.7878757943353384571@noble.neil.brown.name>,
 <02300d56202423fc7277b0ee923b40f00d4903db.camel@hammerspace.com>
Date: Tue, 19 Mar 2024 16:12:29 +1100
Message-id: <171082514968.13576.13734805489700296059@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 19 Mar 2024, Trond Myklebust wrote:
> On Tue, 2024-03-19 at 11:36 +1100, NeilBrown wrote:
> > 
> > I've been reviewing some nfs/direct.c patches for possible backport
> > to
> > one of our older enterprise kernels and I've found something that
> > looks
> > wrong.
> > 
> > It isn't clear to me how to exercise the code so I haven't be able to
> > trigger a problem.  I'm hoping that someone could either explain when
> > this code runs, or confirm if the code is correct or not.
> > 
> > Commit 954998b60caa ("NFS: Fix error handling for O_DIRECT write
> > scheduling")
> > 
> > adds an extra call to nfs_release_request() but I cannot find any
> > place
> > that an extra reference is taken.
> > 
> > The code currently reads:
> > 
> > 	while (!list_empty(&reqs)) {
> > 		req = nfs_list_entry(reqs.next);
> > 		nfs_list_remove_request(req);
> > 		nfs_unlock_and_release_request(req);
> > 		if (desc.pg_error == -EAGAIN) {
> > 			nfs_mark_request_commit(req, NULL, &cinfo,
> > 0);
> > 		} else {
> > 			spin_lock(&dreq->lock);
> > 			nfs_direct_truncate_request(dreq, req);
> > 			spin_unlock(&dreq->lock);
> > 			nfs_release_request(req);
> > 		}
> > 	}
> > 
> > after the nfs_unlock_and_release_request() call I would expect that
> > the
> > request could be freed, so that nfs_mark_request_commit() or the
> > nfs_release_request() could cause a problem.
> > 
> > Superficially it looks like the call should be simply
> > nfs_unlock_request().  This would follow the
> > list_remove;unlock;mark_commit pattern also found in
> > nfs_direct_write_reschedule_io().
> > 
> > Do we need:
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c
> > @@ -581,7 +581,7 @@ static void nfs_direct_write_reschedule(struct
> > nfs_direct_req *dreq)
> >  	while (!list_empty(&reqs)) {
> >  		req = nfs_list_entry(reqs.next);
> >  		nfs_list_remove_request(req);
> > -		nfs_unlock_and_release_request(req);
> > +		nfs_unlock_request(req);
> >  		if (desc.pg_error == -EAGAIN) {
> >  			nfs_mark_request_commit(req, NULL, &cinfo,
> > 0);
> >  		} else {
> 
> See the full code that was changed:
>  
> -       list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
> +       while (!list_empty(&reqs)) {
> +               req = nfs_list_entry(reqs.next);
>                 /* Bump the transmission count */
>                 req->wb_nio++;
>                 if (!nfs_pageio_add_request(&desc, req)) {
> -                       nfs_list_move_request(req, &failed);
>                         spin_lock(&cinfo.inode->i_lock);
> -                       dreq->flags = 0;
> -                       if (desc.pg_error < 0)
> +                       if (dreq->error < 0) {
> +                               desc.pg_error = dreq->error;
> +                       } else if (desc.pg_error != -EAGAIN) {
> +                               dreq->flags = 0;
> +                               if (!desc.pg_error)
> +                                       desc.pg_error = -EIO;
>                                 dreq->error = desc.pg_error;
> -                       else
> -                               dreq->error = -EIO;
> +                       } else
> +                               dreq->flags =
> NFS_ODIRECT_RESCHED_WRITES;
>                         spin_unlock(&cinfo.inode->i_lock);
> +                       break;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Prior to this patch, we did not break out of the loop until the entire
> "reqs" list hand been handled.
> 
>                 }
>                 nfs_release_request(req);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Prior to this patch, every request on the "reqs" list was released,
> whether or not they were being moved to the "failed" list.
>         }
>         nfs_pageio_complete(&desc);
>  
> -       while (!list_empty(&failed)) {
> -               req = nfs_list_entry(failed.next);
> +       while (!list_empty(&reqs)) {
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Prior to this patch, every request that was being handled here had
> already seen a call to nfs_release_request() because we had already
> gone through the entire list of "reqs".
> With this patch applied, we're now handling all the requests that are
> left on "reqs", and that have not been released.

Ahhh - I get it now - thanks a lot for the explanation.

NeilBrown


> 
> +               req = nfs_list_entry(reqs.next);
>                 nfs_list_remove_request(req);
>                 nfs_unlock_and_release_request(req);
> +               if (desc.pg_error == -EAGAIN)
> +                       nfs_mark_request_commit(req, NULL, &cinfo, 0);
> +               else
> +                       nfs_release_request(req);
>         }
>  
> 
> > 
> > ??
> > 
> > Thanks,
> > NeilBrown
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
> 



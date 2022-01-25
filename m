Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21F49BFAB
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 00:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiAYXkD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 18:40:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48736 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiAYXkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 18:40:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F053212BC;
        Tue, 25 Jan 2022 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643154001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUXSTv0zie1Gw+/Ys3ssqa9vSAam43Yqv+gF5PPtx0E=;
        b=NqXsbbXL8sPw6U91d+8s5fij5haeSfocEpXYL31OuoRONz+CovUOu2Ci9b+jt+TvXuIWsn
        Oyn18g7Mr4OFCsgne0fiLVfLLi4NxDT4SamNQ0sxQuBDsCK+LTvnbrVk494AmMAGFFLoFD
        Z3d/UmuMm9l4lbzY/mtpYLcAyBZCVZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643154001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUXSTv0zie1Gw+/Ys3ssqa9vSAam43Yqv+gF5PPtx0E=;
        b=QxGZy3hSX2V0rbfSvJ3fnUR0Ea1hP83+x5CHfmPUyDsPUUpwV9EoukwdWGSyyl3YLpYsgh
        MfycqnEU55JWXxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9799413EF6;
        Tue, 25 Jan 2022 23:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sr0dFFCK8GHzaQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Jan 2022 23:40:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] SUNRPC: Remove svo_shutdown method
In-reply-to: <E1C5753E-6061-41CC-930F-1565488FC799@oracle.com>
References: <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>,
 <164313725230.3285.5420060785593218794.stgit@bazille.1015granger.net>,
 <164314763348.5493.760625882164316264@noble.neil.brown.name>,
 <E1C5753E-6061-41CC-930F-1565488FC799@oracle.com>
Date:   Wed, 26 Jan 2022 10:39:57 +1100
Message-id: <164315399729.5493.8755514018709100922@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, Chuck Lever III wrote:
> 
> > On Jan 25, 2022, at 4:53 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > Could we rename svc_close_net() to svc_shutdown_net() and drop this
> > function?
> 
> I considered that, but svc_close_net() seems to be transport-related,
> whereas svc_shutdown_net() seems to be generic to the NFS server, so
> I left them separate. A better rationale might push me into merging
> them. :-)
> 

svc_close_net() is effectively the inverse of svc_create_xprt(), though
the later can be called several times, and the former cleans up them
all.

So maybe rename svc_close_net() to svc_close_xprts() (plural), and call
it from the places which currently call svc_close_net().  Those places
(nfsd, lockd, nfs/callback) already call svc_create_xprt().  Having them
explicitly call svc_close_xprts() to balance that would arguably make
the code clearer.

Thanks,
NeilBrown

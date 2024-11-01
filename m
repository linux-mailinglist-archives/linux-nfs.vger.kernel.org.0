Return-Path: <linux-nfs+bounces-7624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C089B9311
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 15:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C281C20BF2
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC01714D3;
	Fri,  1 Nov 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaNaLAVI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC728FC
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471046; cv=none; b=ois050+YDiJY6GO9pYlRReIJHiHcMeQowwy6tY4Qw85w8aN6Wkm2ftUUb1dEDJmn6z8hMOC1K8IZ39VODjsZXYRg7Ai77rYliQZlnzATnVJBQO0HNSAP6MpgUBEBDlzB7BJNHWimPGznDLCe9uEtpiymSXw0+v8Z+pFMnCIf8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471046; c=relaxed/simple;
	bh=SRWHjcJRtTVMI/nwe3wzGfbOQG1E4/xkXgpjV6aMK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq2OXaWmqABSia/WaZhNs4Vsptb1MJZFVTNrjo9mWoSbxVwdwvbzfPq+Pt/yhHonKdm3emHMkZqKmm8ydgZK72lXq0O+PUpjs4fWqcczjqSk/ubYl5eR1q74ugE73siDZLL4HAfbYl3JEV5yDsl20TMwINiPmbiv6FO+qX9ALcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaNaLAVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730471043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHXHxIcAV1ObOAeE5zmQlYU04+OBZrYT+UfX7EswcX4=;
	b=aaNaLAVIKY+77EM5JNCnn4dsJdSsD/KP26W0DdmUB2Nvt9Eg/Q4nr2qjYFPkwLHKiBOB1G
	H13y4y1CT9MRLl5kmcWKAA+IKSS5dv17rkcnP4TBie9qDXGUuzrhXBL+JAlE1jX5jwNgPE
	oJHQcScqV6iUsthQjvCSgfCz3ci6v+E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-E-H98iAPOX2wE0OTcIO5wA-1; Fri,
 01 Nov 2024 10:24:02 -0400
X-MC-Unique: E-H98iAPOX2wE0OTcIO5wA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D82F1955BC9;
	Fri,  1 Nov 2024 14:24:01 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2E351956052;
	Fri,  1 Nov 2024 14:24:00 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id CE48221D825; Fri,  1 Nov 2024 10:23:58 -0400 (EDT)
Date: Fri, 1 Nov 2024 10:23:58 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
Cc: "'steved@redhat.com'" <steved@redhat.com>,
	"'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
	"'sorenson@redhat.com'" <sorenson@redhat.com>
Subject: Re: [PATCH] Retry NFSv3 mount after NFSv4 failure in auto negotiation
Message-ID: <ZyTkfsJR8qchH32r@aion>
References: <OSZPR01MB777260693E426F03068BC6E688402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB777260693E426F03068BC6E688402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, 18 Oct 2024, Seiichi Ikarashi (Fujitsu) wrote:

> The problem happens when a v3 mount fails with ETIMEDOUT after
> the v4 mount failed with EPROTONOSUPPORT, in mount auto negotiation.
> It immediately breaks from the "for" loop in nfsmount_fg()
> or nfsmount_child() due to EPROTONOSUPPORT, never doing the expected
> retries until timeout.
> 
> Let's retry in v3, too.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> ---
>  utils/mount/stropts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index a92c420..103c41f 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -981,7 +981,7 @@ fall_back:
>         if ((result = nfs_try_mount_v3v2(mi, FALSE)))
>                 return result;
>  
> -       if (errno != EBUSY && errno != EACCES)
> +       if (errno != EBUSY && errno != EACCES && errno != ETIMEDOUT)
>                 errno = olderrno;
>  
>         return result;
> 
This change looks good to me, but the patch itself doesn't apply (it has
spaces instead of tabs).

-Scott



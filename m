Return-Path: <linux-nfs+bounces-10617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B294A613ED
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E916F5FD
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE10D1A83F2;
	Fri, 14 Mar 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBGVceo5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298771990BA
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963548; cv=none; b=Fo5wBuQPygXNuCcQ2Vk78gvXRxNs1ZUw1H3OeneWhPodFOShgMiTxHaUv7CwVQi7Iii9jL7rDHKPm5Zr8GzSvTc3tMjv9xuxAl5MoozduH6dUV4e6RzNlNgn/LRYB1buIBZZAklzVe7/92Xjx4jhBnvIcDG/8VnJ9pwbZxm8cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963548; c=relaxed/simple;
	bh=93D7l1cxQrjBUqLysHtj812PCh2yyOQSETd91fEGCjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoK1DpYSUxCseT3SX6Y1lznU8OGHktkyOu45xYX+IZp3cvCC/uYUbJD2z+Ac9FGRNgAMcGv+NVI4PfmX1X5vylIYkeZGBRgDP4YvGW9PyIlUI5yLJkaUzLx03eO7Rox9E8MfnIiPsna6TNSW7+aus9bUW94XcMLa5TGauv1MP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBGVceo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741963546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vl0X1Jbbb97TugQoVJnDL5BKnzsdhn9OTbk4HKhMkFo=;
	b=HBGVceo5rW7eAkt53PqTroeIonXYxSIveeyMY1KTDAccEfT19EnisZ99h1Bel49AUPV4Db
	GHjEkfq7zgcHLBpVSeMPiwnPU//dMIeYEQHvsP3sGI2K76j1ao95W0vSibWMQYvgaMpVqm
	v3S5pUN7Lja9oEdOVzK8sLGun+VQHGs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-9JJn4JEcOiOtX9H3RROlrw-1; Fri,
 14 Mar 2025 10:45:41 -0400
X-MC-Unique: 9JJn4JEcOiOtX9H3RROlrw-1
X-Mimecast-MFC-AGG-ID: 9JJn4JEcOiOtX9H3RROlrw_1741963540
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86B691955E92;
	Fri, 14 Mar 2025 14:45:40 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A3351828A98;
	Fri, 14 Mar 2025 14:45:40 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id B98F3338FFE; Fri, 14 Mar 2025 10:45:38 -0400 (EDT)
Date: Fri, 14 Mar 2025 10:45:38 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: "Andrew J. Romero" <romero@fnal.gov>, Steved <steved@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Message-ID: <Z9RBEmMDJ_3FtEDq@aion>
References: <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
 <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, 14 Mar 2025, Benjamin Coddington wrote:

> On 13 Mar 2025, at 7:30, Andrew J. Romero wrote:
> 
> > Hi
> >
> > Alexander Bokovoy provided excellent answers to most of my questions on
> > this topic See: Thread: gssproxy  security, configuration and life-cycle
> > questions on gss-proxy@lists.fedorahosted.org
> >
> > Remaining question:
> >
> > Prior to RHEL-9 , in the section of the gssd man page ( under the heading
> > CONFIGURATION FILE ...  ....options  that  can be set on the command line
> > can also be controlled through .... values set in the [gssd] section of
> > /etc/nfs.conf ) there was a configuration parameter "use-gss-proxy"
> 
> I don't see any git history of gssd.man with use-gss-proxy, but the value
> does appear in nfs.conf.man.  It has not been removed there.  It probably
> should be added to gssd.man.

I also looked at the repos we use to build the RHEL packages, and I
don't see any evidence that we ever shipped a RHEL-only patch that would
have documented use-gss-proxy in gssd.man.

Andrew - can you provide a specific RHEL package version where you saw this
documented in gssd.man (on the off change I missed something)?

Either way, I agree this should be documented.

-Scott
> 
> > why was this parameter removed from the current man page, can it be
> > re-added ?  ( apparently the parameter is still functional ... if that's
> > the case , it should not simply be removed from the documentation with no
> > commentary )
> 
> I'm not sure thats what happened.  It looks like it wasn't ever in gssd.man
> to me.  Maybe Steve D can clarify?
> 
> Ben
> 
> 



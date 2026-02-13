Return-Path: <linux-nfs+bounces-18925-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FEOOqyRj2lwRgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18925-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:03:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF61398AF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8EE30297AB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24720DD51;
	Fri, 13 Feb 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4ALWTm1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mj9PSPmV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB81E1C11
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016605; cv=pass; b=qdtZRLkGB8EbEAZRfpF/i4doWZqSzvpr7sq5ghNPJfsTfxiaka/yd6sZgwlGq1OXBdIFHehCltfBr4u/V78OFTk5Q/7u10Gzxh3bl0fuYrG0cvmLzCro6SQ041hRuMEJ3yrO7xFPXkiUIYY/QS17Wx+KcZk/9hJUlptySAtp7T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016605; c=relaxed/simple;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iAxaJIJEgBduHdKNrNoUs6f7/NxFnk3n19AMfKa4fPtYmqE+QHabzbyUAOE9UMA3pSMW1lS+48t+WWHHGxPnFbhDav8k5cjYg2rVgbf+VhNWnI4wRoQJlZbEtBKixKu7d2AVDSB2BIrcwfmStLoc39XOQAjECkQ24oaj2+gSEDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4ALWTm1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mj9PSPmV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771016604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	b=D4ALWTm1aftRTZg1fwgNXSZjBo5e71hWPIU5f7hbSvdXkNTiGGgc22Ah0DmXIodIQy5aAN
	/3P3fDK0gt68B7zuo6lPBg5UDxtPWTAe8NaA3WWp9XnNSq3yjmICihi9ur30B1iTxmgzaL
	8Igz79bwFw5uBICD2086aYNMBecMzqs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-uEvsVP-2Om6qU4sld-hfUQ-1; Fri, 13 Feb 2026 16:03:22 -0500
X-MC-Unique: uEvsVP-2Om6qU4sld-hfUQ-1
X-Mimecast-MFC-AGG-ID: uEvsVP-2Om6qU4sld-hfUQ_1771016600
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59f6db39e3dso128110e87.1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 13:03:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771016600; cv=none;
        d=google.com; s=arc-20240605;
        b=TAB1RvoajVAxG8v4K2+8nB6uRUK6EISi6TquUMs55zlow28wF99RvCDsDcVUzOVuLQ
         QhZvfR3iMuPNwPJrIZO5pBJHlSVjrghHubFaOM5O4lLg+gJTc8nVrkxuM4wKQ7a9gSQH
         DIrOX9gGiSEfgOTT5lzZ3f9u0riibC2UEHlNQu4/8oGF/haHtJCvv7+/LETk5eeBZt9X
         +P7VZaS7/nvuKMQqh8X5O3g3zoPZWesbQmD6YseiQJCCjhVrxLAlqhkuV3Rpwj8SqbBY
         JNyHCAr2v/nSiapz0cFnA2iF24GAaqLsismT4Bkp/hET5L1xYzkWtHCLgtbQWW63cC44
         66RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        fh=TzCNBP3hrCxbeH0ocNaTgg020iURiPEgFIVDKTKuJQ8=;
        b=JvwgGOokQRShpqc88thpnntELLSxgb3G7WKy9bhAE5jLoL5a+4dFB7JqZHeYPKmVl5
         Czldx4yCKp1aTU4ZITsLgEfHnkBNTUrZOEQ4ThwI6C914U4FbAptFc2W2N9HDS8XSbLb
         wyWzIYv/+KTdIqp5GdWjoHLsvHraVbMNGMtpMjeLKoZ1txXajH9uImF6i8yuRjtHeUvK
         6pS3PY0IbB/EAbSNYZne95rqHcEJWED+Hby96Uvf4/MqsqrtKYYHegPA+wxZKUJ+OIyL
         Y335uDzSC1Bt410jWrrkjZSoEWFPWAwTDWq/loRcApVfApfKVhyosUAq08t1aRPC6mCw
         A7WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771016600; x=1771621400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        b=mj9PSPmVvfhBhcWFsfykyZS6l3q2qWR+VR41Ta4u7QmZm78HGK3kloCAiXiP9S5NZj
         Sp7p2D3fei7M3Io6FVcG5XvjmkxuFfwQB4x4Isse2npz3rx1F5TUPdH4CaDNJCrI7DWe
         axMUobq9vjU58PYyaBiLnec8TY2FfYRIHOCourKSnjn+Bbbb50oYNuRzYCiHnIfbFWuY
         F9fBXf9ptck4o77LK692SD9+egDCAmn2FJlYEZhiH9OqCNtfQDyha5jYncEFRaEKUdPO
         gBthe657wiM3WvxOSCC+RHN+xJIc5MRNwORO2lgjMSi5F9dulsVj4U6hp+P5wBYlTqHo
         jsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016600; x=1771621400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        b=c6HqBYqo5liIR2EN2FBHWRbjw2bprFq4dgyy91uJ0NCplo7YnPA/yje54ohwn7havy
         2XopC/TADfsk8fpxrCdvy91EptZsPZ4vfqdPwWYGNHz3Q1z+icr/JZDmY2b5m7C/zF+j
         VpBhk/2lF2Gk+wU7VusjCyznzd59l6aB6VPB9tNQc5r9MWVEiSu+xkOEBVgkPZf7a3pz
         ej3hGb1CbJd4jeEiWC1/4SNSLr8Uyk40WH9kS5cSqvmtK1TZUX9veARyr7PkFG0gOn7R
         mI3yD3kwqqz/KpW7IefHU9Q1KqtZ9UIf+gokwjRZ9Pijo+W8OHQSFuhaz817oiXs2/z4
         KSsA==
X-Forwarded-Encrypted: i=1; AJvYcCUVB1lF6l8dhha//nhxP5WLJdz5mgMCNNEfwFIa9eQKuu/GXRGUytlynym8lJ+t8fjAlttA9+Yypi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSCI1pGNjpqZp7FQBNnsZqEUGRD7PtmNabsqnEO7XgGv9o+T0
	R9U1QO+Fh/c+tgrMgg6PfndquQ6Zd0gtm5xgwxrSzird+iwFVINzmdBSNz/iMWUjGpDNRUREdJX
	b25+sX+lwR7Zg+9LUSO4exn0tLJvpqruZpRs6VedZ19G01DYlq2T3/v7eaaobayiVJ2qOOuAbn1
	GEjGE235xkrw2pFWyOtx3n/4Q1b9M6ibtTdImf
X-Gm-Gg: AZuq6aJZMArwqze/SHANWUkHjkpnMT6m9HBR5ifTg9aQ3VmYmitwJ3HbJZAOmSa46P2
	QRZpFJp03U8jIfTUQV1J34QpL/uo+N0NM/5rsLMAjOGmeC75fR7sPWSadsEgfXXYpS2SG6YWWtP
	yV0hjbELakasR3a6OG4PDsbV0YOheXTM/Lp/m0n+gWe+NHZxt55Q99C6QwA0gADe5ZOYr2AUJjN
	vHdqzTW/enA+aLhpSjKrTNlppbJoAhokVjA4MqL
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id 2adb3069b0e04-59f6d34c80dmr210940e87.2.1771016600014;
        Fri, 13 Feb 2026 13:03:20 -0800 (PST)
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id
 2adb3069b0e04-59f6d34c80dmr210929e87.2.1771016599486; Fri, 13 Feb 2026
 13:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 13 Feb 2026 16:03:08 -0500
X-Gm-Features: AZwV_QgZDC4BMfr_62OBKQIGw1rPOpj8cinGnFyTwRxTcGMVGoVWq9ZzvvqAjuA
Message-ID: <CAK-6q+gVhsKKPPax52nju8HXPApPyO9zE_jUygDxvhF8BT8P9Q@mail.gmail.com>
Subject: [LSF/MM ATTEND] distributed file locking
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-nfs <linux-nfs@vger.kernel.org>, 
	gfs2 <gfs2@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[aahringo@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18925-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 51AF61398AF
X-Rspamd-Action: no action

Hi,

this proposal for LSF/MM aims to start an initial process to discuss
improving the distributed file locking API in file_operations.
Initially the file locking API, used from the user space via flock()
or fcntl(), was not designed for distributed locking. There are known
issues e.g. specifying a process id but missing additional information
about the distributed entity where the process is running.

There should be a way for users to opt into additional distributed
locking extensions that provide specific distributed locking info or
even introduce a new file ops distributed locking API. Designing such
new behaviour requires community effort to become aware of all
distributed locking use cases in the Linux kernel. Examples of those
users include DLM, NFS or CIFS.

A recent proposal [0] suggested offering the file locking API only to
the user through a virtual filesystem, using DLM as the distributed
lock manager backend for now. The filesystem's concept can be extended
to offer other backends and allow experiments with new "distributed"
file locking API extensions until the community agrees on and proposes
a stable API.

This proposal discusses an exotic and very specific topic: distributed
file locking, which tries to map to the existing file locking API.
Users working on distributed file systems are aware of the challenges
involved. Solving those long-standing challenges will be a lengthy
process. It might be time to start improving this situation.

Please feel free to share your thoughts on this topic.

- Alex

[0] https://lore.kernel.org/linux-fsdevel/20260213180014.614646-1-aahringo@redhat.com



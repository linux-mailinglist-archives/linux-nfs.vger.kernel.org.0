Return-Path: <linux-nfs+bounces-5028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5093AFF7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 12:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B351B21ABA
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198715572D;
	Wed, 24 Jul 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+jhxyHl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224045695
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818147; cv=none; b=o1xs61gVi/3ctu+mLU8+5oaCbAsduvnyUd8+h4PeDjidwmjiQRtmsh3fQ6ei09jk4tlkz+jwyD3xTA1MuHEeG5MO97K0/q+rr13yXrkLBMGHGwxkl0aMI6qTHV2dY/HZd00kYbCkwKHO08HGjJHM5VAAkAR079PUU8zaC4Protc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818147; c=relaxed/simple;
	bh=mk2ZxGX08PNv4YoAz0u/yvwIIa5RthzIaEdormYoflw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dlPwIUc+tvYwCP0lJSKSqUVQTwrh7GRnUHwak5SEX0PqZTEKNJUIgEzubSbnzAvwaaXIVmKMp2AaOds6GCE3lB6PgMfn+wwnYjoLs+PS0QYzEwXiFcFeWX2oeviP2mvpf7j8NbKXOuxSBQ5KvnzNakmy9h+gfRRLYkbrKFVIECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+jhxyHl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721818144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsngfBhfXF66S4vlOR5CuNqs7S4pOb0GrulPVPj4ysU=;
	b=D+jhxyHlVLZOw0o6+/K6ihZdjiY3VaEahbBsIt6RkOcvRulqRapRBc/Z6sC04+5rtHIROI
	8sU3LI/RhUChzrGHZcCoCC7kOlkuxZY4MjgKevwYOSdVaAakDzk0FjiQ0uhjODfOS6VNgG
	IfKO+7UHSd3wDVk3jflV9ZMUCSq+o/g=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-AImHpoaeOXOXIXPpJwDzGw-1; Wed, 24 Jul 2024 06:44:50 -0400
X-MC-Unique: AImHpoaeOXOXIXPpJwDzGw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8206b0ef05cso137445241.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 03:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817889; x=1722422689;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YsngfBhfXF66S4vlOR5CuNqs7S4pOb0GrulPVPj4ysU=;
        b=CA3tLhy4T+X/fjZnRZD645oaLHFFPCizyBmA/9VIShgCsSPu/ONdsLNyV9W/MG0iZc
         auzBA/3RqH+BQP9uAK9COLzW4rT/83MyEnLXMAnxX2D6zoNc5KL7yqX4hnU9O+2SoM++
         Zql3/zsRwYrcXAkz1K4rpmbUFQT49/VZoeDiIGdSzTL6E3U0K2fVZPAOyAxC1riENZSC
         sTKqTIHr1v87YOADNAJxjjedaUaKmVv+RZA6W9WoPbWaS3meNUT6GNhVa6iQwkcki4iH
         JnxZ1K2gqymCkRRzJ+fzQ3+8cZNGjaG8kbcnlmE02FskETWpdXPpl2EiXVRx1N6O71nj
         tJ8A==
X-Gm-Message-State: AOJu0YweaPep5dHXaI1heQfvBURCCWXkHVzf77lWtkVQ26qr36s6EmVZ
	czApFHO3ZxMF8E0j3pliavLOBulwnvDBP+webZ3afymhvEGD5DvMpmUtB4d/zMY9TdutIRJmN6d
	IgWhZqDgxgmwg87pQvFmX7JLAkyrZRfmt3rjReM22BMuu3OuV4X141SFNWwHktvbSYA==
X-Received: by 2002:a05:6102:26d1:b0:493:bb70:940 with SMTP id ada2fe7eead31-493bb700c03mr2521488137.2.1721817889364;
        Wed, 24 Jul 2024 03:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAEnPYMI0XoDCt+nNd8iDuW1JJWvgxkzHJWLnnRT4z426CL89KhM84bVmhwllOwpdmeVvDNw==
X-Received: by 2002:a05:6102:26d1:b0:493:bb70:940 with SMTP id ada2fe7eead31-493bb700c03mr2521478137.2.1721817888987;
        Wed, 24 Jul 2024 03:44:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbe00csm570080385a.47.2024.07.24.03.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 03:44:48 -0700 (PDT)
Message-ID: <356074d4-81f3-4712-af74-85ef06b1c3ec@redhat.com>
Date: Wed, 24 Jul 2024 06:44:47 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: [Libtirpc-devel] ANNOUNCE: libtirpc-1.3.5 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

A couple of rpcbind enhancements and a memory
leak fix... as well as a few other bug fixes.

The tarball:
 
https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.5/libtirpc-1.3.5.tar.bz2

Release notes:
 
https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.5/Release-1-3-5.txt

The git tree is at:
    git://linux-nfs.org/~steved/libtirpc

steved.



Return-Path: <linux-nfs+bounces-14368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B2B54F21
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE735A29F4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CE2AEF1;
	Fri, 12 Sep 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3HAKQak"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30F3074A6
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683025; cv=none; b=j46ZfWgdc5I9APZfCUuyywtcNu/9UtTgxdbd64G7alTkbbjRRpppNW6Ce8uVhO5pBwVg5fHzHk2oWmUI4vzbZECCcIFQ8Jd9/otxauXl9/Rdg5EiY3UIDCG/3dJHoc3HYhguAnF75gwB7HhkRAlrkMV6fvvXWrZnM2Atbbk46yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683025; c=relaxed/simple;
	bh=HUotpdxSABv1lyYQxUIX2UPM/oLyxUnuS2uFxCWtHeE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=mupAbxNF3h3iKKp6RxCoolsSpLE5HYhmkpadYwQkG+MA64un1R4ZP0PyXSEZeMo5bB/HC2VHa4PCfDnYT6fBCXUUGSmnOebuMPDedTJaQ9HBEomE9HjRnhufdRX19fQXh9h39LRf3GPCYhizgog9HZnE0XdIqKlQUnXR2dwrDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3HAKQak; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757683021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xekp7EDDzr0m2PAiQg+EXramAasisk4ChofTFwXbhdM=;
	b=Q3HAKQakK29dqKQJMQSfgXvCQ7EUddOyshpHdseVrD7yP9h1aN6AdAWG7scQNOARpMaXMX
	y04/PN9lqGRIDqWO8XoEJBKv1cUG2S6g1Dnf6bhjYtpMNMyWfiHNNywLav30T3sgBkxx4u
	F1/KPVndtMb1Dn8OA0JtMz4QbNGveHg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-LHWRa3mzMYSZJIyDkXQVnw-1; Fri, 12 Sep 2025 09:17:00 -0400
X-MC-Unique: LHWRa3mzMYSZJIyDkXQVnw-1
X-Mimecast-MFC-AGG-ID: LHWRa3mzMYSZJIyDkXQVnw_1757683020
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-52ad145c42aso501124137.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 06:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683018; x=1758287818;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xekp7EDDzr0m2PAiQg+EXramAasisk4ChofTFwXbhdM=;
        b=pYZRK6mKK8PY7+olSIMYnrQwmFmcAve8oxlltu3zQDkQPijzJNVsw+WavRv2JBKh2r
         gilaW9590DuhqLffZgJEpgeXuA0/J9q2+7k44vapYBxVjfh9Y4WwjE2gQi//n9cii6gi
         KpKbI89xoTJCiGdCOHyKBsqhwsFfXAWIzhpp8s2h66COL3Xb2m5wt4eFI99ep4TBCWW/
         96iqwTBe5xr+Cd1aKBP6rDuIeYdOh7sXORIGiY3VlNq9rkc6a0avhOP2oC9auiDephQz
         hMppfAYiSVtzzrFbpA+HXPlrG+4C5Lc7Da+QbCmAS6XzxOFcGHFe89HX3OYpO36pheZr
         Ixsw==
X-Gm-Message-State: AOJu0YzDlIKyq1h5Z8qdW06pAEQr6068l3DzD0GfU64UfkobWGJ9dW2i
	6Y8RgPozSMHuJah/2PkuFtSFcg59MbrvYpXTnTxEkOeq0tdYTyyeqmRmBNM+3h86cGe4DzbgR4b
	zsgChON5F+G0MeJPe9Pqk3UmEmo8wHM0s1HzJzQ42R9wYY5hSYADp9eW9iLzpEuhEJxH3OnaCpG
	BOMQy0aUN9kle9XPivgYEpiRx9UzE7vVvHe7qLE9KFrWQ=
X-Gm-Gg: ASbGncv6U8YlwR5jS++l646TszNbWNCY+YlFTMSrZ1J7oZhKkhDR/brZuthasN1iqEQ
	8nYN9DoVUTl8fYw3jBuL5PbJzkjydSouuHD6IGatPTax4H9ogzo1c9yXRmWUNFdog6CdH64nOAC
	gCC12Payo9tKOBrhf53+0rzBO5SeUkM7uzr6vzLLPgiDU5/J5Ro8r0pkzACMhdNqIZTGiTWus17
	Y5fbWI52RiGVef1UzICZ7gtgRvsahDdfzObFtOW1HmNYFIeA0FNu5qDz3XCUvSsm3eHMJ2A7u6t
	SVFJ54iK7meE6CUrK7Oo035A+b+WMsq6dVQUEEpJjrygdT5J5OhwbBu+vsTCwEuSkLtu9UfMB2n
	0AISHpB3y/zNa
X-Received: by 2002:a05:6102:161f:b0:520:c9fc:4cd6 with SMTP id ada2fe7eead31-55610dc11bamr999745137.31.1757683018169;
        Fri, 12 Sep 2025 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy5p9XVJyrKpSYkBmYux9zpNWbBN4mg8XJyO3zO3aD26LTDabBnfSqlm86j2Hh8UDjM3J5cA==
X-Received: by 2002:a05:6102:161f:b0:520:c9fc:4cd6 with SMTP id ada2fe7eead31-55610dc11bamr999652137.31.1757683017483;
        Fri, 12 Sep 2025 06:16:57 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:e99e:d1e3:b6a2:36ac? ([2603:6000:d605:db00:e99e:d1e3:b6a2:36ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce386b67sm260230585a.53.2025.09.12.06.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:16:56 -0700 (PDT)
Message-ID: <6f271c01-cd4b-456b-80ac-77a96b99a1fe@redhat.com>
Date: Fri, 12 Sep 2025 09:16:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.4 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The release has a number changes in time for
the upcoming Fall Bakeathon (May 06-10):

     * Added new support to rpcctl
     * A number of systemd updates/fixes
     * A number of bug fixes to nfsdctl, gssd and nfsrahead
     * Warning fixes for the latest compilers

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.4/2.8.4-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.4-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.



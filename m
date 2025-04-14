Return-Path: <linux-nfs+bounces-11124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE6A87E1F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337C3B2AE8
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Apr 2025 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9327C86D;
	Mon, 14 Apr 2025 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5saEp6d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51C1EBFED
	for <linux-nfs@vger.kernel.org>; Mon, 14 Apr 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628011; cv=none; b=RzhEglWPyn6Uy+XWX1LqIKI2OH4vuwZuTqelyIcg/p6BBNE40X/uUJ/YBKwYHl/TMUGgaE4Sp740s3M1zzzLN3V7VCM3xPuyYdwgsJJmhQ5debTqnS9gw2yIzQWgqdyA8ddcZwuQ7CJXw4NVXBGMQD5KgiYqARk2sQBsyf3s5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628011; c=relaxed/simple;
	bh=i8UFVfLVecE/OkBEcbn7OeI+IvLd733RRqhhh0d5tg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Imc0SZouCXwy8V6ux/0Qfh+hTw0WjqkuuC6HVZiSFK8AQs3ra+rLHMVxyztdzHQgvvj6zag652y7EcwyrYF/4aJ0G9lNqarL5gcSyG6dsop7irdGQEGfk9dDPUVONNWhyE0Oldu07EqNwiJuK3XMgRtQuat9Qbf0t5DeDKfzzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5saEp6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744628008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QssDdryN4XzwB2ObD+whRE7b65oyqcuIi20l20iYWjQ=;
	b=b5saEp6d9ZRpv2f6Ym5f3SAXWHIhC2H0qSJ97NjDv9avcvUzcpym4GVnLwKH4IAe9PMtOf
	g/WAZbnKBUagXTO8UukzM2mAPb+leVKhImJ70z3IW1ECV99GotXJEalxUE1hlvxSzOx+Y7
	qS7Nq1sa03q7DvUmG39jFO5hFgP12Sw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-bQB0npX1NMaskzuhA2Z9PQ-1; Mon, 14 Apr 2025 06:53:26 -0400
X-MC-Unique: bQB0npX1NMaskzuhA2Z9PQ-1
X-Mimecast-MFC-AGG-ID: bQB0npX1NMaskzuhA2Z9PQ_1744628006
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30566e34290so4556421a91.3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Apr 2025 03:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628006; x=1745232806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QssDdryN4XzwB2ObD+whRE7b65oyqcuIi20l20iYWjQ=;
        b=i12wR5wNlOUAYkXBrHR4EX5VRQ0HV/nt3fV49Q5yVD6rOZyOt3CbmCDZoX3M+UWjQr
         nOraP5BNiyhd6v/xJ850cXQn1KnUVzdbKEcrMIbLNmC6Z6qxATr2IbP+tuo24RPNA+6X
         vmbPxarkG+ljQHEtXdAg2k7yOCJf2MsmAiDWF0VSlkNGhs8e3wXpoY1dd1q8sH/imjbS
         cyjrphppUU1Hs2fCJ36xlq+lLHZbCd49793xMb6Z+VVn7Ce9SmILq4h2dGnft5BAvdBT
         Gg3jyvH9M5RCv5W+wU6P4LrogYSyfkUeQW5s6+RQCXo0jYB+rTXFZOlAxCa+B/dkceTf
         PSmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Q8wEQBrcvv8Fs7VbJkMWuq5lp5NIkR3+J1JqMjr+E+TKRBQqpJ/0KlUav4qgjpT+pr1ciupz6tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxtUF2KZp59jHTsjVQd+SIM30tPy6UrjMD26p1oi9tBjg2DPl
	3Ij2PoPlTaumrREOyVl+6VxEX1laxvdr28FslTkq4JaZ34aUOV095VT0C++FNG5fR8xuyxzVomP
	aXkKtuzh12zLRRrb0980zo5uTCmPwFaILDpDY171S5bn3trBGgmjEJrbHYse5LUrODN88HQv+0n
	516X3HIpX/MB7CGopERkRrJSiveyGPH9XJ
X-Gm-Gg: ASbGncsH9FZqdlb29esWpwu9LohovYtgIaKFAmvnfc0vQ+SEZrHy6frNqyiGexWNy67
	ZzGx/4F4RHRDqRHpYF84u3nCjNYy3OHDBrGlgT19p6ElXR9CHWvmD2aXLRMyP/MQSGx4waIdFil
	UUbSM0UU3UdRNHzL/IGtyjoun0lA==
X-Received: by 2002:a17:90a:d00c:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-3082377bf6emr17374459a91.9.1744628005671;
        Mon, 14 Apr 2025 03:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1RQ4lutpYCn+Kaq6I6KhtiVojLcDa95CbKbGEjQZmsp7rcx8Um4wnI+nq8RtXvDW862mAFQnIMpcjZ2unsv8=
X-Received: by 2002:a17:90a:d00c:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-3082377bf6emr17374447a91.9.1744628005214; Mon, 14 Apr 2025
 03:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 14 Apr 2025 12:53:13 +0200
X-Gm-Features: ATxdqUH0l3nfdPAcTuR_HE3HJVDFxQf3jn1qi3rAw2RBx76Mc5KftSBiTI7qpGU
Message-ID: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
Subject: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc: clean
 cache_detail immediately when flush is written frequently")
To: SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: multipart/mixed; boundary="00000000000084531d0632badcb5"

--00000000000084531d0632badcb5
Content-Type: text/plain; charset="UTF-8"

Hello,

I noticed that the selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
test recently started to spuriously fail on latest mainline-based
kernels (the root directory didn't have the expected SELinux label
after a specific sequence of exports/unexports + mounts/unmounts).

I bisected (and revert-tested) the regression to:

    commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
    Author: Li Lingfeng <lilingfeng3@huawei.com>
    Date:   Fri Dec 27 16:33:53 2024 +0800

       sunrpc: clean cache_detail immediately when flush is written frequently

It's not immediately obvious to me what the bug is, so I'm posting
this to relevant people/lists in the hope they can debug and fix this
better than I could.

I'm attaching a simplified reproducer. Note that it only tries 50
iterations, but sometimes that's not enough to trigger the bug. It
requires a system with SELinux enabled and probably a policy that is
close enough to Fedora's. I tested it on Fedora Rawhide, but it should
probably also work on other SELinux-enabled distros that use the
upstream refpolicy.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

--00000000000084531d0632badcb5
Content-Type: application/x-shellscript; 
	name="reproduce_nfs_mount_regression.sh"
Content-Disposition: attachment; 
	filename="reproduce_nfs_mount_regression.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_m9gxjwo00>
X-Attachment-Id: f_m9gxjwo00

IyEvYmluL2Jhc2gKCnNldCAtZQoKc3lzdGVtY3RsIHN0YXJ0IG5mcy1zZXJ2ZXIKCmZvciAoKCBp
ID0gMDsgaSA8IDUwOyBpKysgKSk7IGRvCiAgICBleHBvcnRmcyAtbyBydyxub19yb290X3NxdWFz
aCxzZWN1cml0eV9sYWJlbCBsb2NhbGhvc3Q6L3ZhcgogICAgbW91bnQgLXQgbmZzIC1vIG5mc3Zl
cnM9NC4yLHByb3RvPXRjcCxjbGllbnRhZGRyPTEyNy4wLjAuMSxhZGRyPTEyNy4wLjAuMSxjb250
ZXh0PXN5c3RlbV91Om9iamVjdF9yOmV0Y190OnMwIGxvY2FsaG9zdDovdmFyL2xpYiAvbW50CiAg
ICBzZWNvbiAtdCAtZiAvbW50CiAgICB1bW91bnQgL21udAoKICAgIGV4cG9ydGZzIC11IGxvY2Fs
aG9zdDovdmFyCiAgICBleHBvcnRmcyAtbyBydyxub19yb290X3NxdWFzaCBsb2NhbGhvc3Q6L3Zh
cgoKICAgIG1vdW50IC10IG5mcyAtbyBuZnN2ZXJzPTQuMixwcm90bz10Y3AsY2xpZW50YWRkcj0x
MjcuMC4wLjEsYWRkcj0xMjcuMC4wLjEsY29udGV4dD1zeXN0ZW1fdTpvYmplY3RfcjpldGNfdDpz
MCBsb2NhbGhvc3Q6L3Zhci9saWIgL21udAogICAgc2Vjb24gLXQgLWYgL21udAogICAgdW1vdW50
IC9tbnQKCiAgICBtb3VudCAtdCBuZnMgLW8gbmZzdmVycz00LjIscHJvdG89dGNwLGNsaWVudGFk
ZHI9MTI3LjAuMC4xLGFkZHI9MTI3LjAuMC4xIGxvY2FsaG9zdDovdmFyL2xpYiAvbW50CiAgICBz
ZWNvbiAtdCAtZiAvbW50CiAgICBsYWJlbD0iJChzZWNvbiAtdCAtZiAvbW50KSIKICAgIHVtb3Vu
dCAvbW50CgogICAgZXhwb3J0ZnMgLXUgbG9jYWxob3N0Oi92YXIKCiAgICBbICIkbGFiZWwiID0g
Im5mc190IiBdIHx8IGV4aXQgMQpkb25lCmV4aXQgMAo=
--00000000000084531d0632badcb5--



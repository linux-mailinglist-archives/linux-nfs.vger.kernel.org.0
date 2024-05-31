Return-Path: <linux-nfs+bounces-3512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B18D681D
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61062B259F1
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A1176AA5;
	Fri, 31 May 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NY92oSB7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D255E4C
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176236; cv=none; b=ICAMgVthBlnlxsfMr0wLdSKngJnoBtqESpF+50Z+Or6C+pSmC+qJHZSHJjVrfakAwRMG4RFaLKD7bcGAf5kcudCoDC7GBbjhjEHzxjyKwIJsyTtjqZ53wS7Rpc5jhqagpMQY73ILSL4C4QC/iDgRx4omo1i2Tz6Cze4FoH/yQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176236; c=relaxed/simple;
	bh=QIqNdZW6qbAa9mdDqBlX4maeQrhqkv56dFYUdwsq/6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J0DQhpn8uMCx7FJqZoiGU6UEEGMlF+l9j3L80VfZJlnSgNHDGflCeDpM6VxMihkKYsMl2AUA/hdtzYg7M6awVjgoYITV1prPJHfaFPPonNry7/kuBYfCJvYcNCy5jj7YI83CJRgFLMbqR4omZOjXOauSuMl9JG54758JY2HLIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=NY92oSB7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ea82452e3dso2395031fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1717176232; x=1717781032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIqNdZW6qbAa9mdDqBlX4maeQrhqkv56dFYUdwsq/6w=;
        b=NY92oSB7BINhpcibkFAfYTS+lgghp36MEO+ybkAApJyL+9J5lRTvW21lDvKdBaNcLS
         /MHIHRYVBJ+UwtwgYr9pU6479iKEsKk2Cn1lCFUt1Q13cbEMzbmXYQsbSvILg4Z0Nxwy
         GgsSGEZG7/adEFO99EAaJOdARHVpe0ri8GS37NihuPt+oFB2oCmlK7vk5nizLcTXWbgf
         Npj11+x3QGM//P7YF4q40OW77uFhUPruv+1XVtJv2BCW15v2Dedbif4QAPhUqFGyefOB
         h7Oz7ebFWpE4zEmVi/H8PeZ6Aqd/8rohdfOQeKvXlEonbkORAHY98jzZAdVFQdrs5LZo
         No5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717176232; x=1717781032;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIqNdZW6qbAa9mdDqBlX4maeQrhqkv56dFYUdwsq/6w=;
        b=WSoBtWCOpVMI4IC/bgy4VxMrBwyXgdlhQpLQ0z0J4XAQt6BkD8EKCo1pDBYpdnPMlK
         4L8KHRj+xujJKXwhv/xgEnkVSakt/HA9FkoopiV10hCtsezg/+fV04drmpqz15OZ4URg
         Gv93Pj0ojRN+W+ZU9sHLIuUUbI9T/5BZMQx2OEX0NJ7QR0qxIqGve+knSgec5LYt8meg
         Pn8BcgWNst3N5rGIqelITJ0u3Sg9EHSFSkyQRybwNtsgsh6bfQwXUMy1X0fEZY12pTV0
         xWtEzEx9D2ZTjROj11n63orgyzarVkd9rIM0SuHF62qncSd8zfSm/ad2Xf5O2KmmaecY
         3lvg==
X-Gm-Message-State: AOJu0Yy3RKByZyJjcT3KUIXsAg/eIeVvhqt6HC2NtcW/4OeeY5fJu65f
	Q+4m1Zt0yjf8oIKtArOWhJW1L95ozzhy05PGzxFN4z2F8Fx89BIMdOK/0lF0hnf6lPaG+k+MnmQ
	Y075cdbSL3x6BDCcsWim2nca068ynyTFC
X-Google-Smtp-Source: AGHT+IF7jMCIUBYJ3x2ZRaOEIetwv/CGKMGqTKrPDF1/Ox1bHuvr+xm+4lTqwmnXnPfvAsRniavz9OXvWCpvajoZh1Y=
X-Received: by 2002:a05:651c:1992:b0:2e5:2aa1:a76a with SMTP id
 38308e7fff4ca-2ea9524bd8bmr19511761fa.5.1717176232211; Fri, 31 May 2024
 10:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 31 May 2024 13:23:40 -0400
Message-ID: <CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com>
Subject: ktls-utils: question about certificate verification
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Chuck,

I've ran into the following problem while trying to mount on RHEL9.4
client using xprtsec=tls. After some debugging I have determined that
the reason mount by DNS name was failing is because gnutls insisted on
having in SubjectAltName=DNS:foo.bar.com. Having a certificate that
has a DNS name in the "CN" and then had "SubjectAltName=IP:x.x.x.x"
was failing. But when I created a certificate with
"SubjectAltName:IP:x.x.x.x:DNS:x.x.x.x" then I could mount (or just
having DNS: works too but in that case mounting by IP doesn't work).

Here's the output from tlshd when it fail (with SubjectAltName "IP")::

tlshd[260035]: gnutls(3): self-signed cert found: subject
`EMAIL=kolga@netapp.com,CN=rhel94.nas.lab,OU=NFS,O=Netapp,L=Ann
Arbor,ST=MI,C=US', issuer
`EMAIL=kolga@netapp.com,CN=rhel94.nas.lab,OU=NFS,O=Netapp,L=Ann
Arbor,ST=MI,C=US', serial 0x751ad911565945cce5d29d1c206450538f496b90,
RSA key 2048 bits, signed using RSA-SHA256, activated `2024-05-31
15:07:53 UTC', expires `2024-06-30 15:07:53 UTC',
pin-sha256="Efzu7ftve1SHxBVAIwf81jwAasQ0M3j5qWbEVuM8X8I="
tlshd[260035]: gnutls(3): ASSERT: x509_ext.c[gnutls_subject_alt_names_get]:111
tlshd[260035]: gnutls(3): ASSERT: x509.c[get_alt_name]:2011
tlshd[260035]: gnutls(3): ASSERT:
verify-high.c[gnutls_x509_trust_list_verify_crt2]:1615
tlshd[260035]: gnutls(3): ASSERT: auto-verify.c[auto_verify_cb]:51
tlshd[260035]: gnutls(3): ASSERT: handshake.c[_gnutls_run_verify_callback]:3018
tlshd[260035]: gnutls(3): ASSERT:
handshake-tls13.c[_gnutls13_handshake_client]:139
tlshd[260035]: Certificate owner unexpected.

Question: is ktls-utils requirement for IP presence in SubjectAltName
now requires both?


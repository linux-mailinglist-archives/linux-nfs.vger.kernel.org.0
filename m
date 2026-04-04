Return-Path: <linux-nfs+bounces-20659-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CALbOBN40WluKAcAu9opvQ
	(envelope-from <linux-nfs+bounces-20659-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 22:44:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63239C6C2
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 22:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16BBB300DE13
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA421638D;
	Sat,  4 Apr 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiUX1dRK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5MMdvEi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9632DB7BF
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335434; cv=none; b=Eg0ZH2pk3otv056qwmLwHhUIu75pJ3Q9ERwpr+/dwDXCqVx0i9zYkOHi9gzqnU8ctL8O4xCwwWqaw9f09GHHUAyjS32bsvqv7TWaoDu8ZKClNlZDN24oKbGyqaoM+7B4SlZsHPLuEDnwlNHLUw1s5blnOCzqsHZw6GHpzmFWuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335434; c=relaxed/simple;
	bh=sr4upe7AA7Sopus3JvBlLh5PB1VI0KChYdy/WW84TDw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AY9oD/xcJAJ+d8O2FGPD0jdMkMmTSn08//+sR1m2aXMusZDql+IoVGRK7Vi3yrY0PhA5JyqOQNm3F0lTXzLiK9OzvNUim8FzA5YZRslczxngMNqmj2qBZumpyOr2dkPTl7t6nw9uePCCbqwXGVnBOvU3Lb6cKxPQT7QBvgmiIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiUX1dRK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5MMdvEi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775335431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
	b=hiUX1dRK8mdS93B6ZGqc5RE4sHWQeJsNHdL3WIaY1f/aLnTjoOgdOmdVc6HR8Gjl/XE4ii
	+oYs81yjEFMCkYQymD6rO7BjpV9ZN8fNLpLi84Y2ZO5LAg2KduuQl+RgBuzad/33zXDepe
	Ap8VoI6euQdcT2P+QJz8MvBAfqf/xU8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-fgMH-rv4PeeRSLxW3Qw8UA-1; Sat, 04 Apr 2026 16:43:50 -0400
X-MC-Unique: fgMH-rv4PeeRSLxW3Qw8UA-1
X-Mimecast-MFC-AGG-ID: fgMH-rv4PeeRSLxW3Qw8UA_1775335430
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a22dbeeb96so78820626d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2026 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775335429; x=1775940229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
        b=d5MMdvEihd7dvlXqfmumrdNr1YZ0JDBFs+N1Os/+2o9W9HcDdfTCcYlAw1DDMXho6I
         7oSw+YIviviOwZeBcSfLVAiXdXUUtPw3TH4XrsdDKsObsjynzyFnRsWd3QCdHJ7JK+yG
         ldKqljg/SZG0XFsZMhBoUx5D+ZEqdRIQLP0dthYY+NtPCZd7tfACrzXIUqz3o0VjxTFz
         po/90QABGTZI7B0HfZ9OSKyqal6399Jtx8rKFOYJJq1I95WzMOD+fb3sC8ZztdEikV+S
         dNB5Ga5dg0oqZFqhmCXWG9gnvTdEWoMPlIPYW8S0pvlyQTSzcqjUDBa5uAy20j9SPkzp
         nFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775335429; x=1775940229;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
        b=SXuM2qRnxJ2dj5LmJ7t9oIHs0utOTZkX99gP9bZdZd5SCF0lcmFpjYyj3n46G3xiRd
         lxvtxKVNC74iIpZigxJi/jOjx/TDSEi07E3ZY1d9YL7iHPBelNhnf7aY1H6qQf91Jric
         hlSzCwx277FYRld5bLG0iwRmZIdyHUMs3WqQYoCWGugBzLUa01ORCxQ8a3zgNSU6/Zvk
         ggUSgDrsP/EYddXEibOVRzMf40dZL6tkS5OlwJyFNlFEuozWU1oitKilTHxlTbZHu3V6
         DD2NpnUCH9WB1FcPF1Of6uOFA4ePqcxcgPE25l10Yd7a5F69c+L+1GTeuPo/ScO0HXPn
         oHxA==
X-Gm-Message-State: AOJu0YwaDAUDuWYtqVkgxQcrP5WDyg9/ubjOpCI8oASHeGOGGIUHJLap
	LjG1yTa5MY/E34lnOwF83wFduqOCNKpxBQk/AFNIsthRZj8cvh5op9WWojtkdi5gCpGJ92ArK+u
	DHMcEKV5VMCs6Jvbe9qcmeKkeXFUEA8Z2sevzHLyyuXpklmMpGVrZPgWhg0BvasWlC6WfTxA6C8
	MoQg1j5L23nrh3DlDbV8OZeCBP4A0Xc7/0h9xcXLMJsd4=
X-Gm-Gg: AeBDieuewHjbTavLWxU7xJhYhcmQq4vxbEkDfeEtpqhfL8REIsNqK25vFTE1Ux4Ny0/
	bDM/WFlfkF0R72nwqe377j0TsdWSijLqbRg2RYKSY1tzSIhTimMxsofsarzVfZXKLPtaGKz1OR5
	pI67tPaai5Y6Cb5oz9IbZUh9995TqSQNdiT1zJ/3M121Cu/ydpKpYQ5uKiCiHo7yyUUyxV0VkLk
	2WjfSa8r9Sq+dwVmFTsY8M/Zq3Fs8qietBBfGrghkLvQoCFckSG31kprCTtwPhmuRIv+RGdAYcW
	U/4Z7aJ8l2epsgbcUXQGSIYIKIpTM197XICHuOh8nZ4ygqvvkkL06pJ5vCoFWIOzFSArEcIDvCH
	gtlJD0n7W/FkHUXMH/U+ytg==
X-Received: by 2002:a05:6214:5f0f:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8a7048cb0d9mr136634896d6.46.1775335428988;
        Sat, 04 Apr 2026 13:43:48 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0f:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8a7048cb0d9mr136634666d6.46.1775335428297;
        Sat, 04 Apr 2026 13:43:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5976e223dsm95438116d6.45.2026.04.04.13.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 13:43:47 -0700 (PDT)
Message-ID: <955a922e-c12d-435b-a698-caf73312f01d@redhat.com>
Date: Sat, 4 Apr 2026 16:43:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.9.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20659-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E63239C6C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This release contains a minor version being disabled
(which is why the minor release was bumped),
new features and a bug fix:

     * V4.0 is turned off on the servery by default
     * netlinx is now used for upcalls in exportfs, exportd, mountd
     * signed filehandle support was added.
     * nfsdctl now checks for listeners before starting.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.9.1

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.1/2.9.1-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/2.9.1/2.9.1-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.



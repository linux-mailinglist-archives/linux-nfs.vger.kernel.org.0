Return-Path: <linux-nfs+bounces-8512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A69EB68D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63473283492
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8522FE14;
	Tue, 10 Dec 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFgOiPvD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02522FE05
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848492; cv=none; b=ok+zdD++Kglzj1GubQ8jq43nSZzNrD89SMcKp0bogiWxkwdzqAhzU7zfYeteR4/WhmRLmSZ7TX2SuI9tlfFyOCBsmldBWzPMlONmpDYGrSQJMvvJjd/XEC34eaA38j1lgcViFSdnmLMkMOkWlHdFelv9WR5ijepU7yTKDzXreaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848492; c=relaxed/simple;
	bh=Lpo2vZaBFZ9IfUboO+9t7CHFBfsidafSj7ecseQdVf4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EtDF1gtk20GfUnwXZH0f231W841cs4BfHPAO0mfoSUs8Wa8b7veC4hyVWqq0Uhe9VDVOW1DJvli1MfGB5mmUYu/LO1aW8MyUphMHaoZ7nR7pHYdL0HQXF7GxwojM3fiqccnUAH3k+rVT8n9SrvNfgku8Z+q8kH/rEMFDXP0XdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFgOiPvD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733848490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LWq1R5t7u/uGdOKCQ+B2EHAR2OWt6/s5zTLeb/gvY5k=;
	b=jFgOiPvDPJaiQqlzJ+Zhuan0yurNFY/Ofjm5Hz63bBTuE8S4Zby4QOmGnAKbdFvF3QRH5S
	OLzMSEnKN7I7gjdnTvJIYn47P6bbr/xpUlO/Fnw+Q8KghKvyLPDMTlbwG+jN8iNN6DlAgD
	48pPA2DPK+U2lvKfnBxIDQMSvciXjZ0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-ao-VLvPlMnyREA1It68uWg-1; Tue, 10 Dec 2024 11:34:49 -0500
X-MC-Unique: ao-VLvPlMnyREA1It68uWg-1
X-Mimecast-MFC-AGG-ID: ao-VLvPlMnyREA1It68uWg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844bc3f2992so88113339f.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 08:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848487; x=1734453287;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWq1R5t7u/uGdOKCQ+B2EHAR2OWt6/s5zTLeb/gvY5k=;
        b=SHdd4BCOXDzSpzLtBqJS4tWGGoCzaLTG85G8k8D1ZntrUtTh18VZIpNBYHY5mZ2ZSF
         G5pRpidyj4lLNeJxVhzb5qIYaBzZSsr9gixz87gaKFZGxsh+6E2hP3i4xiDRavSBpKm3
         tlaF71toawJzqw8sfQ2jmi3ibyytqi9GeReIHM4+krLLxME9J51ITRrx9ZpDDxa5NbEH
         oz86nnqXLrJMu+WBTBF7T6ERIvTwg4a2wH3tzrB0XQcqrkWNnRy/dkTJbMRn7q8rDZMy
         mcNNSBSopymbe3lObnmVscyJtp7XIqondhfBZ6y7y1u7rlgSU6DUu3biXV1zqNOer1k9
         o99Q==
X-Gm-Message-State: AOJu0YwV7HdB/jbxFbvtuiCPS1MFlkHBBk4eKDLiN/4iHNE53wDBYWjk
	RAwnFNsvSkSeQiKT0ISAKGpg8zOjQjf9o6xEJNh/J6QLOdFhDz5qWY+eaF1/zPCZBZpsJTXC5G1
	JdylYdWxcAsWxR85Bkkkt0xW5Uxt206B8ZSd/7wYFh/k1Nwef4DPLMAZF03DQBaAh07YU3e1fPm
	WhDDksfCf6ON1WKh2y5UlW0jlYo/xQz8rlpCBdKVc=
X-Gm-Gg: ASbGncuHGb+I06plzLYHjri83G9tRM67ZokLxhMVMeDj3LBlgFKTsvqrL1mpJgT70dX
	b77RttTLJct8O9+LiNMDpkxE/IEMFbb3Q82hbHlm5XGvJovzODMC3FK2Mv9utBg/zkXdfMzjhkd
	ilUR2LV0EaNYZBtRbBS6tFv3yra0gAFWPlvzzBZyPtUriPK779rM8/iYfJvVthJvVUL+tTXxefD
	iizNN+3sOHvJSPB7Rir/UEhtwoPFDIFVpkahokhYOQ+xd1tbai4kQ==
X-Received: by 2002:a92:ca09:0:b0:3a7:e592:55cd with SMTP id e9e14a558f8ab-3a9dbacde30mr41004705ab.14.1733848487549;
        Tue, 10 Dec 2024 08:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5uarxXy/ATe+aoFypuvD8esVgeX96VRA0wKFAPIyTQ35TL8LZ6TXYQMK5hHtLZpUR35Xb+w==
X-Received: by 2002:a92:ca09:0:b0:3a7:e592:55cd with SMTP id e9e14a558f8ab-3a9dbacde30mr41004505ab.14.1733848487113;
        Tue, 10 Dec 2024 08:34:47 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bcb00135sm1257730173.106.2024.12.10.08.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:34:46 -0800 (PST)
Message-ID: <84536b3d-5a1c-4f47-a08a-ec49cc977176@redhat.com>
Date: Tue, 10 Dec 2024 11:34:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.2 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This release changes a couple of defaults:

    * nfsdcltrack is no longer compiled by default.
    * The number nfsd server threads are bumped up from 8 to 16

This release also has a number of bug fixes including
a regression to referrals and addressing compatibility
issues with musl.

Note: If/when we add the URLs interface to mount there will
another release in the near future most likely 2.9.1
since an interface will be changing.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.2/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.2/2.8.2-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.2-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.



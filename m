Return-Path: <linux-nfs+bounces-11004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A07A7C358
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AC43B2741
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B71B4242;
	Fri,  4 Apr 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="n9aOIgIN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E6195B1A
	for <linux-nfs@vger.kernel.org>; Fri,  4 Apr 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793065; cv=none; b=tXD4gmBYrcq7pDap7x2dJ0QHgCSLAUWOIdc4x38X7Sk2RkUXTRTa7xXs9m4/l/tzWFFZQ3Kmwh6U4H5GoHLAfKaz9I58+E62Y2EsqdMJBa8bQVzBHQHB5uMWF4gkXfTzfPkSZce0zq+W2+fCK8KeKIZXem2BzzEoz2CrDlsta3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793065; c=relaxed/simple;
	bh=de386EFIOUxFGlJdP6khmVLjd66LlTAtplBu2HcHo0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FLwhbgmetMUgXGjbwdY58oOVg0qP/gQR7hN+jvNx7eoXU3zQxkMw3rZ4rgNj9GS/IBx6GpbdYwZfWyWusBSKLSm/xnd6R4F8T37I0pGGpTCZD8Sud4fGUCaw0NswqES0QYqIv8eD+FGvvCmDVek9wdVtyy9CcoRQOvRKtDhYhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=n9aOIgIN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7395095e9afso180027b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 04 Apr 2025 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1743793063; x=1744397863; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H27b55sIL4VwsW9rzj2++VVABVZ+EIcz/Ji91Y4Dl7w=;
        b=n9aOIgINDu0m5MSRMZsaGBxpcKjsuicTMxlwXxrTQ4QwOtdpcWSJCunfnJRWdr1hkD
         HZmsy5O5Rmm6RxUfEOP+GoegAs4Qkm8vmn5DiDYvfNLmlHuWgRQC4v2ZF14VdeGwuJk3
         TbpogxQvbb3/OhMvZuVf1jBPNs2dUhhHoGwjzkrv6zUfCaqdgrU8z/xKIw0WBVZDRral
         /APtjI683MmkIf5Imcj7ZSmLyyCdb3HJ4oStXhS5NpkM2Y8KkOPp08aYmxxh1PNhF2fH
         XGA/wZVOHgdFnG7eppg0Y1dvI8aBPW5rG7PXfrfTAJhYn3q8F4FE23xmJWOjhbrlBitJ
         uygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793063; x=1744397863;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H27b55sIL4VwsW9rzj2++VVABVZ+EIcz/Ji91Y4Dl7w=;
        b=MZ7JegIUY2CfcIhNNJQ4VoPFZlFtQzefeILWZKMjTQKI+5Xp9vtpCVd3T5utZ+LqwV
         9HDBg0WrRrx1BtJkyFwQzw0+jNSTl1jYf5ih9BPTb40PaQH66miOqatXe71VS48lFC7G
         1+Abm+o3N6CTPV4jHCz7a1ztmABKXF/zHUqsNXJuVRPsrGtn1pcNmVdHsnt6K5q09Gaa
         PR+u9LTLjvLBAB4tJnOXEDZAROA4J/8/H8WEQpIE8b4eDn2EJTAY54yFFA5fjhnkYg02
         UbnvGBIKPExyg2OP02+4YwX/kFAJ2ZO3ofcBBqZwO8ezRbul2LKh4nq+MVzenlIQYMyF
         OJtw==
X-Forwarded-Encrypted: i=1; AJvYcCWVtyzBBmgkAu9MV+qbRBqd6VWtCb+gRQMjrCFyYSUF/UIcyvi7SQ38+u2I+L1Hd094YQEvFxGKrTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8CdRh7uQ/6usmdOqtRev9ihBYC4AqiSP2T0IGFVM715CZaWd
	zxUJh36ZucyHzUBo9j28TObpDuaC0iaWEzvQqihSu2fnE0dcgVpO+y88m2Q442MpzWepYodqld1
	z
X-Gm-Gg: ASbGncvxSbnUQp/vuggXn5CNvCmFflAK9GyGzMgJ7rDCbwhE+ALr/ineTz39jiZCkqj
	jYAzZCB1cXMU0xG58OjNiAKYuXncboVg5vU7ywH6J9TcC00AEYN9XREUh+dNpufmcTj+xVu/qQ0
	j0/jjM7R1hSB7vDc+o+QoM6pcbS5a8NjnAvgVxKbFZokz1iD0O++zUQeL7DdJQBhKi/8K4OmBc2
	ictejNMoX+oeUBdKGKtuykU0Oh6QiSlyAjS2IhiidYd3lPjCTTsKVa4Me/D29qSHhox9ylOxS/v
	YYybslgLG5iliaBcLChnYEcCELPQ
X-Google-Smtp-Source: AGHT+IH2COP4zRoWYkRWCM5LlgGUUi1DbhUTiJaQ6OYCPdPwwdUf7muBal8jdM2XpgxutFxNlmLPKg==
X-Received: by 2002:a05:6a00:1412:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-739e48f8e09mr2318671b3a.1.1743793062820;
        Fri, 04 Apr 2025 11:57:42 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:500::4:2b52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1a62sm3760721b3a.32.2025.04.04.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:57:42 -0700 (PDT)
Date: Fri, 4 Apr 2025 11:57:41 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: Leaking plh_return_segs in containerized pNFS client?
Message-ID: <Z_ArpQC_vREh_hEA@telecaster>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Trond,

I'm investigating an issue on our systems that are running your latest
containerized NFS client teardown patches while Jeff is out. We're not
seeing the NFS client get stuck anymore, but I'm debugging what appears
to be a reference leak.

Jeff noticed that there are some lingering network namespaces not in use
by any processes after the container shutdown. I chased these references
through:

   net -> nfs_client -> nfs4_pnfs_ds -> nfs4_ff_layout_ds ->
   nfs4_ff_layout_mirror -> nfs4_ff_layout_segment

What I'm seeing is:

* The nfs4_ff_layout_segment/pnfs_layout_segment has a pls_refcount of
  0, but hasn't been freed.
* Its pls_layout has already been freed, and the nfs_inode
  and nfs_server are also long gone.
* The segment was on pls_layout_hdr->plh_return_segs.

    >>> lseg
    *(struct pnfs_layout_segment *)0xffff88813147ca00 = {
            .pls_list = (struct list_head){
                    .next = (struct list_head *)0xffff8885d49e0f38,
                    .prev = (struct list_head *)0xffff888dee919f80,
            },
            .pls_lc_list = (struct list_head){
                    .next = (struct list_head *)0xffff88813147ca10,
                    .prev = (struct list_head *)0xffff88813147ca10,
            },
            .pls_commits = (struct list_head){
                    .next = (struct list_head *)0xffff88813147ca20,
                    .prev = (struct list_head *)0xffff88813147ca20,
            },
            .pls_range = (struct pnfs_layout_range){
                    .iomode = (u32)1,
                    .offset = (u64)0,
                    .length = (u64)18446744073709551615,
            },
            .pls_refcount = (refcount_t){
                    .refs = (atomic_t){
                            .counter = (int)0,
                    },
            },
            .pls_seq = (u32)2,
            .pls_flags = (unsigned long)10,
            .pls_layout = (struct pnfs_layout_hdr *)0xffff8885d49e0f00,
    }
    >>> decode_enum_type_flags(lseg.pls_flags, prog["NFS_LSEG_VALID"].type_)
    'NFS_LSEG_ROC|NFS_LSEG_LAYOUTRETURN'
    >>> lseg.pls_list.next == lseg.pls_layout.plh_return_segs.address_of_()
    True

So my guess is that there were still segments on plh_return_segs when
the pnfs_layout_hdr was freed. I wasn't able to make sense of how the
lifetime of that list is supposed to work. My next step is to test with
WARN_ONCE(!list_empty(&lo->plh_return_segs)) in the free path of
pnfs_put_layout_hdr(). In the meantime, do you have any ideas?

Thanks,
Omar

P.S. I spotted a separate issue that nfs4_data_server_cache is only
keyed on the socket address, not taking the network namespace into
account, which can result in connections being shared between
containers. This leak has a knock-on effect of pinning dead DS
connections in the cache, which other containers may try to reuse. Maybe
the cache should be split up by netns?


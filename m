Return-Path: <linux-nfs+bounces-6522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADAB97A84D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C4F1C214FC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980D4174A;
	Mon, 16 Sep 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtmd+MGZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FB15B551
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518455; cv=none; b=Lh6suELHxw8byQRtsdQCOl/2zwdGXT+K2iNAAIlc1FuWBwM8pykdRpc1ivXXAjgay+/HsO/Y4HpO9fPiXlhM9nZJOqenADqGQK+jZ7MB2+4iitU8OqZOSGSGkEE7H94mSqTJaDFGvtsuQRY8R0UOFcaFjEY28iuzV4PTsKciF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518455; c=relaxed/simple;
	bh=Or748Ljk2t4xFD8EYMVcyLV/krRikkzeZpKtKB19nEs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qiUiab8ves9CXjsPlM78y2J+EcJa6olwVYXcNRzPBtUP59icRdvKDxPVJoY8F/r3qwoQJgSaRTGh/DrsbfYTPfwIpx+I61lplj9MwzxZTW8mib9IvBQo/UNc84/dP2WqgTAbqDDJJnGbdt5iikKGWI8+vUcHmUvpDCGNHV/L4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtmd+MGZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2db89fb53f9so3277552a91.3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726518453; x=1727123253; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEvjSvPzewfcVBXJ4s6VdH1ktY3HyrbT/JVIMnFr4co=;
        b=Gtmd+MGZ5DZk+5CUf8oyVhw1hmeyLlRL9hH/eoSWcMIQG+QGN/YaYMXxTGYyrwlH+6
         X/3vGlU+FFTudR7Uatnzad5jD++rrbuzzxd/5g1b1Jb1CA35pyxdlFRpLgDzy5a7t0jX
         R42a2JdQvZZTM2kxAxlPDXv5cJAt7SvcKQpemK7y567eEUgzfn17Y5s4gjRFelBUhY+w
         UCYFcM5pi0j/xe7Tv0a2erUcI3d379LweiZhujEpemHkrYE2vtGHyE53dyWtztzoU18x
         rVDNgdQm9M6GCcA86D22isSNnRaf/EOexxCg2ea71zHYZBRnHHw0r9QhfGpQjxpbe9g0
         QXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726518453; x=1727123253;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEvjSvPzewfcVBXJ4s6VdH1ktY3HyrbT/JVIMnFr4co=;
        b=uvuYVFBWnK7QYHENw/aa9E92Nl5VEtxEkOni368cpmMz6PijSmRRy46mccfVekJwSz
         yXFzJRldfPfWiVeD7TtbqHijeomIGL53Adtrcwp0Dcm1QPT/AbjjdgCINpRYs9BQzgcC
         ncCFKbHAdOKSFPAcIhk68ql/LSFJLwzPc8sLLgpOUSbIdXE5Qn9dEwPfn/o51ctG2G8R
         MuOGvctnDhebbD4UPz3OS+wRA3dnGvl3T2V9td7dnLeJC5+GVoeytAR58lMUCknqdPQr
         uCc9bm03zSXUQRnBVxk375K2KqogR8JKw/G+VEtkH/k65KkEX1noBT/md9sOYiZaWCb9
         kHWg==
X-Gm-Message-State: AOJu0Ywk2Tsq21Z3fnF25gKCoEWFtJ0C/EtsV4cHE90GSS0bGccAZfc6
	kozkljGkpPjqblYcPVwRprWX8KYJ65LItGjsIbmf0aPNhzN8dTP1
X-Google-Smtp-Source: AGHT+IERVYMSwC2Aztqa9LqbU5cNh/2xasG8/iyT6mHxrlV5pjCWuaMczxzxLa2zzTvjXaCD8YK+JQ==
X-Received: by 2002:a17:90b:14b:b0:2c8:f3b4:421 with SMTP id 98e67ed59e1d1-2db9ffa74camr20067690a91.4.1726518453117;
        Mon, 16 Sep 2024 13:27:33 -0700 (PDT)
Received: from [192.168.86.249] (syn-075-080-015-010.res.spectrum.com. [75.80.15.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c71bsm7883256a91.16.2024.09.16.13.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 13:27:32 -0700 (PDT)
Message-ID: <41ee5118-027b-4630-8f02-b3a67c61b328@gmail.com>
Date: Mon, 16 Sep 2024 13:27:31 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Olga Kornievskaia <aglo@umich.edu>,
 schumaker anna <schumaker.anna@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
From: marc eshel <eshel.marc@gmail.com>
Subject: issues with Linux client pNFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Who is the current maintainer of the Linux NFS client?

I have an issue with the way pNFS client is distributing the reads among 
the DSs and I can provide the traces if anyone cares.

Thanks, Marc.



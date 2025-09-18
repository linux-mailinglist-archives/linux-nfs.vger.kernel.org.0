Return-Path: <linux-nfs+bounces-14556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E6B84DAB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E524A1A79
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC7A31;
	Thu, 18 Sep 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C9NEbTna"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E72628C
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202397; cv=none; b=TnwHQ9UXywOg1LyV8wveU4WmSlY9yKulYjDb7IBUUNfGiRY/RbgyGNtAR3qT0eMRjNHvifMNf9kKWRG1J7Ib8gtE8IZrY8mNq2S2JLZqnkoZirEMLttLDny+w3wPwAfNqnfVu8z6gKrW6pY5grql0piP/FZ8V5T6FGCA3plysBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202397; c=relaxed/simple;
	bh=49YPrQWLSwV6byblfvieGpG8FdEBtSIXJTpSl+zcFho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AUa/NZB3EZjfH6uo2WAIVkgFPzVtF9it8ji/7wsRiQCHB6pqyyjmDMaiquAOJv2t4udzn8yBlppobgHH67Pe7Xhf+ptJR4ZAiRAvSeTRaGgs2O7omU3fimwKf5Pbtl2lKoBvCWAqqFwXJm/N6VZYrzoPfk/5r9ik+t0ZBiYc1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C9NEbTna; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07dac96d1eso312094266b.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202393; x=1758807193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca3WMICiY5snQqpqZHx+J71YherCM5+J+jUfTHJLSAM=;
        b=C9NEbTnamx4TD1eupWtxY/uuUJaX4PUl9wF1fL5JXHi7Cxcd9ORWqg1yyjSyzYK2RZ
         e7Mr7+8QgiVlucEfWSCAqutJq9nurRSp/wzfIwF3NO2KsumVcwOPJZ6/EO8pLpYeUiB8
         tRc1q/Q9NAZJCzeFB5hsgxH6PlQjBl08daJxwU0MIQ1ipfhtudKe6B+EQi6ClaqL9Xuf
         b2aojkZ5nBmnlO7VAHedmbpr3gquqQZ1bmWyCPcKuA8xKJb51f6H+3mV3XdDkcaSERfO
         QZKl40pFfxt/KI5AcgC5n+O8AwZ4SEIj+/qZWTtU/r+weUvWqpkN5JAa9tAGcvnLuZhv
         QLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202393; x=1758807193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca3WMICiY5snQqpqZHx+J71YherCM5+J+jUfTHJLSAM=;
        b=vpRvox5SrsIs0AkbLo2cFaPAdK4i76FrdvuDc06rC4am9bdue7r7352uLWJFfRSibg
         uibTt+EMdn91I/53KrODjq5GSJJuxUMi3+RPuN3xHy4xZHnv8Eckt0+OGycw6+5cYxfn
         NfXVl6rLNquCzyghdNFc2mxz7RC43PzG5VywrmoYo9NX3HauuJmL713unWMxpyAjX8VQ
         Uy98vQbF0k78AKn19+EZqVcYp5143qjlPNeZCPZJHMpwAViiCUBGUhxhnQvVvVpVQf2S
         D/zUvDgT+pFCsjZA45fXZgpOORqjE+k/wqkW/CDCFN0ACNnlkbWHrmJVitNL7U2K/R33
         SN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTkKtY7wQV6U/ghysiUMITW18RUfV+5tk+/ShJIvLouYy/h/rgSwdCsLI9bUNIxPsfvtgMCgEN3wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUA0XXbC+82I0C+UTt1MKiLjAQA5j1KpV6H29w7IPV7zWOVoVT
	5AgxU9dWmBWTU5Slp+l3l3YWf+xVd7WybZ+LWK8EwL53jnzLFxRxDpbmyZeuAoKfil8=
X-Gm-Gg: ASbGncvNjp7QHvVeEGn4x8UyW02pVroOcXZ4x/HDmekHuYS85HBYPcZ2fMU8EzMdAIV
	ESCpWB7FVLvQ0/eWLz54N7Cy+++ra5k1WTX+Urt5WtXt+mVkj7aQdrMSMXXeFCRnhNaC6dEnfuu
	QqOJOG1LPfcEJP6gPFkan4MXeIG3nO74M/sFjWYqTeW4OsmESNT0RlSEYaRXnsmyrH9aBmCK+T7
	0vgdRXKzFIhegSDzzyY4FqmSKLcBDgTpslpQcx0UCytFrd8SJg/XRT+xqZ8BsUETmkkJ/oy5pmW
	tZa0xRrB6bLjH+zterjcu+tLR7ynh4IOJFaBe8bCMs8bJ6aSA6TRxsGtinRoTSmqY3IPzjDZf6h
	fXciWUyEli8YaWErYlHiuzBRQEXKFlLJLEKE6RTIi0A==
X-Google-Smtp-Source: AGHT+IHe/qbkRtWhaNpKzQie7KRy7kbsHGmDxkzatWAUzjH1yMj4LeW4r7Cqg/WC9KsZYjoGBr5iIg==
X-Received: by 2002:a17:907:d02:b0:b11:ce93:4388 with SMTP id a640c23a62f3a-b1facbb6f98mr357525166b.25.1758202393374;
        Thu, 18 Sep 2025 06:33:13 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd1102093sm196483966b.83.2025.09.18.06.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:13 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 0/9] NFSv4/flexfiles: Add support for striped layouts
Date: Thu, 18 Sep 2025 13:33:01 +0000
Message-Id: <20250918133310.508943-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for striped layouts:

The first 2 patches are simple preparation changes. There should be
no logical impact to the code.

The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
array of a new nfs4_ff_layout_ds_stripe type. The
nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
the flexfile rfc. I called it ds_stripe because ds was already taken
by the deviceid side of the code.

The patches 4-8 update various paths to be dss_id aware. Most of this
consists of either adding a new parameter to the function or adding a
loop. Depending on which is appropriate.

The final patch 9 updates the layout creation path to populate the
array and turns the feature on.

v1:
 - Fixes function parameter 'dss_id' not described in
   'nfs4_ff_layout_prepare_ds'

v2:
 - Fixes layout stat error reporting path for commit to properly
   calculate dss_id.

v3:
 - Fixes do_div dividend to be u64.

Jonathan Curley (9):
  NFSv4/flexfiles: Remove cred local variable dependency
  NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
  NFSv4/flexfiles: Add data structure support for striped layouts
  NFSv4/flexfiles: Update low level helper functions to be DS stripe
    aware.
  NFSv4/flexfiles: Read path updates for striped layouts
  NFSv4/flexfiles: Commit path updates for striped layouts
  NFSv4/flexfiles: Write path updates for striped layouts
  NFSv4/flexfiles: Update layout stats & error paths for striped layouts
  NFSv4/flexfiles: Add support for striped layouts

 fs/nfs/flexfilelayout/flexfilelayout.c    | 786 +++++++++++++++-------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 111 +--
 fs/nfs/write.c                            |   2 +-
 4 files changed, 645 insertions(+), 318 deletions(-)

-- 
2.34.1



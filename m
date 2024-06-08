Return-Path: <linux-nfs+bounces-3619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABE901204
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Jun 2024 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868B41C20D57
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Jun 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C13178370;
	Sat,  8 Jun 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gvk3ptrU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB017BBA
	for <linux-nfs@vger.kernel.org>; Sat,  8 Jun 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856773; cv=none; b=R+uKWY5Nq5Y8ndX67MEtdxA2kbw47RIGiAimoM6ErsIIwgQTu+ZcnqkLaYj3WKmn0t3s58trWWGaNjZBeQ+170Y70sAxcgz+z5BEzzAdGeGvrwVDlOwTwl5w4L8Qr95WYEvZl2qVFSLO32PK/FQuV767S55KfyHB4ZCFmyPRCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856773; c=relaxed/simple;
	bh=6pjvm0bj2eyfLgd7Edv8xaFdr8mHKwGZeHRmbZIH04E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JPd8QslXwodDNbYvZa51xrGMvurg/VdKKrdJHnlY5fuKTtC7bRRKwvVWmEcRjzO3lb+Vs1sz+Jgb5RZuWMbKh7Pt13brYRD7IAC61qqnkilME6So4WUVrrx1XyqR0ItU8UvbwXPqFmUBsIlO6NCLsuprJU0PkcNMnVAvkp48Z6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gvk3ptrU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c819f6146so426051e87.1
        for <linux-nfs@vger.kernel.org>; Sat, 08 Jun 2024 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856770; x=1718461570; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxvsbnsFVjeGHUDxYUhJ0rbPaZCbM8X7RUV3ynLZmic=;
        b=Gvk3ptrUpgV501keB5xF4RjrpN3+2BRYBdw8iVkgX1QeIwir7oUWKGod9WHJDJsT5N
         rBCeaPwYcoridzKT71rgHjNZBYr1ignRaC1LEPPnshAnkoEB3kPzsAwQevzRqVLwSMAC
         xlCnnAl8hnlaoMQU5lRDSQah8V/yq9i0rd0Tk01IekbSwTu1Vc8G2R8N5fcrBBB/4UB0
         qLO9wc5Pt0YpO2FI1mAym8XcGZQj6Z0tsVAfJNxvN2ItPS8Gft/xyc0xrPSrhnUSJqkm
         NoL9RWYLae7WWLEbD3pS2QkkiX8BUfHQz2TrYV1bJYLaXEXuPk4l6491oHCuLF6KCcOw
         OC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856770; x=1718461570;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxvsbnsFVjeGHUDxYUhJ0rbPaZCbM8X7RUV3ynLZmic=;
        b=rPgTh4Am4pldJUuhleTsnLewjj7GX1DDpyp+aDKu/m9Pc3wVR+V9tChIZMNqnlNOu3
         QNr8hbmQqPvHWncdFZ2/MJEdLHBOzZ9CXjZsIA9VD7xOkV2PbDXY+2qDNVJgs7aTC+8T
         3nsow8sOXXbwRgZ0wr+yhQHsUB0108AdjmNKLexB/no8aCQnR3CHOl6BnL2CgUg1Yvvy
         rXtIm0PaDaTRYXnXzCoCiLOQWEPz7ejtUeKT0W6A6hletFbFQ5NYO7r/30NzE/4rN+rV
         E4RE3Wam1nKIgtOUxz3LXsOu0Sda+pJLjHHK4byu3Mc0gvz8kcrriqJntTNXtQ3SkQTW
         rG+g==
X-Gm-Message-State: AOJu0Yz5jNuDd2oAjSBYDTp8Y0HJvEmFR3bhwvBD1dmp1IvvauEp9eO8
	VLCFmOMZ9PP7tzBFKglpYS+QDkjumklKGkWKsf4IW8k6j5pw+CJiSedpKMHg210=
X-Google-Smtp-Source: AGHT+IHbIILudoPm/XYwaT1KeoDaW4LlyBHeNT0euEvUDa7pvMEH2wX2Qn1OZhrTvgkhNFSyl0Lbgg==
X-Received: by 2002:a05:6512:3d27:b0:52c:8417:cef7 with SMTP id 2adb3069b0e04-52c8417d079mr261604e87.42.1717856770219;
        Sat, 08 Jun 2024 07:26:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a827sm6501847f8f.36.2024.06.08.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:26:09 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Use of mapping_set_error() results in spurious
 errors
Message-ID: <ba14adf7-722e-4281-8746-36311ab01b18@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Trond Myklebust,

Commit 6c984083ec24 ("NFS: Use of mapping_set_error() results in
spurious errors") from Feb 15, 2022 (linux-next), leads to the
following Smatch static checker warning:

	fs/nfs/write.c:318 nfs_mapping_set_error()
	error: we previously assumed 'mapping->host' could be null (see line 315)

fs/nfs/write.c
    310 static void nfs_mapping_set_error(struct folio *folio, int error)
    311 {
    312         struct address_space *mapping = folio_file_mapping(folio);
    313 
    314         filemap_set_wb_err(mapping, error);
    315         if (mapping->host)
                    ^^^^^^^^^^^^^
The patch adds a check

    316                 errseq_set(&mapping->host->i_sb->s_wb_err,
    317                            error == -ENOSPC ? -ENOSPC : -EIO);
--> 318         nfs_set_pageerror(mapping);
                                  ^^^^^^^
But the next line dereferences mapping->host without checking.

    319 }

regards,
dan carpenter


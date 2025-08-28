Return-Path: <linux-nfs+bounces-13934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86253B3A25B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9916CB9C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A83148C0;
	Thu, 28 Aug 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YugAGREp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFF313544
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391917; cv=none; b=snIdZDJa6mr9fRgujcc0qbQfpMAgCLUK/pJRtFUGNeCJsQ+NugS3gestDlHeObaOeyLuNmbPJgfubBhRcZ+tsbClI/IBeYr7ztZ+yRgCBbA4VLVD8CrV4YXwM/BMMQ0cpAZPbvhIW2HYPPXWDJicJ5ogjT2A42ueF3dv3pTLjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391917; c=relaxed/simple;
	bh=rghtA+zPjgC/sqREv++eMds+gzEaa7DAmwO+hcP5ZYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwQ50V2MNKfvllw9KffeG6CkeroUy4wsS49c2OY/i25bKsX9A9XEN6hupyVfSbkIFWI1utascQj76ieul9AvsIJLEOFAZj7y3YzSNnV8QgFZHggZTbbJNOfq/9k2nJQLoy7zi72D+wrl4VOCN+7BsbXpdw8OU6t2/k8+juscVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YugAGREp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so6285535e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756391914; x=1756996714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uc4dbMtwt2feYcHGwcjwdf6g23A4j5ZdvqLEgcDdLUM=;
        b=YugAGREpA/zPgik3J9O4BFzVm3UNaeC+UkZpW8nae+lgGaJM3VyGASKKV5GS7qdRnM
         A8Vt3ANAzwSQeX54vYuUE2HNXCSMQ6Wr9OB+KJpNr28GJXrxXxWO1D6s7Eu1spSsqkrH
         opfaNfFjJgsTMPNo7bnVQIK9lWywg3yuQYZCFj2/IXYbvUp+63kIhrz58P3jU0wcHkaX
         SgHS2IEVKPVhpmWDumKW9ZrMHI3FZ5Qdc1ZK1DJ03juOZyL53igQC6pqRffgM1BLiWIb
         YLaHVvMRlBP6ybhyyvwSOkmVzr4Y6gxTWeco79lv3I+43NRgsbIbquDjXy1mEkb0ECnt
         j6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391914; x=1756996714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc4dbMtwt2feYcHGwcjwdf6g23A4j5ZdvqLEgcDdLUM=;
        b=jmKT4FptBIag2sY9wfrxk794gGXBlfbf+1MB6QgFOWKUsYCxZTiN77PB9aR6eczakE
         p4sdTS9lcjaWKj3c76uP0uRP1TBW1Mfqd1YrcXJTGT4ceCuGHYEUZ9kQ+4tAvKLLoYVL
         2rdRaUkZggTZZJ2SoCRnYjcCTEQ1Ynsdg9Z1O77J5ChyrkXYbXjb0nrCioHzk9cimX5P
         AQJ91Q01KyY9cTU3m0F2JE5j+hkn+F4MTSqPhHHs9YhKXuVNGP/9wDhMTHuICUHlkWUr
         t/560jRrYdhKpK/wx5xJ6afbt3lxOSCMw/lJT5qxNxkwm+odJshlu2Pst8CW0ESmXeQg
         0JJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIjTjL3wtzvflbRrhfFUGzhpCqXxFmPng6c1R94FdSaPAZDtMdmfQKjf8muwthrHKB7OsADS++kFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BLrE7dDvugWqy9yYgaL1ageBP4x6T/UWsXa1UQKfQVzUbSZ7
	j0GC3ndPPbAytWm1oFByYOfzyKVVYaxOH95LVQBXKWR8rJpAHeSsUg9krKgXNGZYgVo=
X-Gm-Gg: ASbGnctHcZ+mzaKhycaQWEz3PO5lgIDZpWzZg3xuyr9RGdt81N/cyl7FasgmgFm9QsQ
	H0QdX1HwyR9bmfH7jBMnYWrxl+Ciw/KnCWPnq9oKaEFuPKnUtIHDn53Gtmx9vYmeXpkAMo2F4BB
	X3B13zhdkvx+O5/fFJHx0bB/9XddzFg8gUB+nW91AHFgAnGxenpgt6JhEwvAjPYaE9s2AdPKrRV
	RvRBCo4Cx/+SEeNJmi3bOdXzbdg+kDFUghTkhpJy/VhJywt/Fi16V4xF/jiD84clM7fA+SxNPGN
	9blTBiPCZLpqynfHp9GEd/VOoEnqnNzbuDrJM1oSUwzwhXrChinLcD2seW0Q3RLlU6LMUbKd6QO
	2XAHHpqFH5bgyezcBLxulpicDw1lbx3xoXn0s1g==
X-Google-Smtp-Source: AGHT+IG/vJbEc0zQwzNC3jJpROeLK9kc4t9We4VOkAVFNR1hrd+7/wynehLB9zMUM+O2YuA7WmL2Pg==
X-Received: by 2002:a05:600c:3550:b0:45b:7db5:2c7a with SMTP id 5b1f17b1804b1-45b7dd28893mr4424195e9.1.1756391913588;
        Thu, 28 Aug 2025 07:38:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f306c22sm78123485e9.13.2025.08.28.07.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 07:38:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:38:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc: trondmy@kernel.org, anna.schumaker@oracle.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] flexfiles/pNFS: fix NULL checks on result of
 ff_layout_choose_ds_for_read
Message-ID: <aLBp5eajfo00ew7D@stanley.mountain>
References: <20250828133843.1057488-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828133843.1057488-1-tigran.mkrtchyan@desy.de>

On Thu, Aug 28, 2025 at 03:38:43PM +0200, Tigran Mkrtchyan wrote:
> Recent commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
> errors") has changed the error return type of ff_layout_choose_ds_for_read() from
> NULL to an error pointer. However, not all code paths have been updated
> to match the change. Thus, some non-NULL checks will accept error pointers
> as a valid return value.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS errors")
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---

This is still not complete.

  1073  static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
  1074  {
  1075          u32 idx = hdr->pgio_mirror_idx + 1;
  1076          u32 new_idx = 0;
  1077  
  1078          if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be:

	struct nfs4_pnfs_ds *ds;

	ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx);
	if (IS_ERR(ds))
		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
	else
		ff_layout_send_layouterror(hdr->lseg);

  1079                  ff_layout_send_layouterror(hdr->lseg);
  1080          else
  1081                  pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
  1082          pnfs_read_resend_pnfs(hdr, new_idx);
  1083  }

Also the continue in ff_layout_choose_ds_for_read() still needs to be
fixed as I mentioned earlier.

regards,
dan carpenter



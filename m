Return-Path: <linux-nfs+bounces-3154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E68BBAA8
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 13:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3D11F21CEC
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81017996;
	Sat,  4 May 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msW3Zqk0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF43171CC
	for <linux-nfs@vger.kernel.org>; Sat,  4 May 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821815; cv=none; b=BMG+Aff4EvxzZHyYdFgZSVJR38oNv4mUEqproln2kTvjOmZztU+Pa5pGAwgiCYp6iW//KMzeoqpwHqyvu3gw6cF5FmXwFwKYTQgEmH5svZNiymP7Br6v2T/gO3FmI/1LK0tYDGAw+grzgSLty7Ic9HcKEc7yRqkk8BhMnvfV7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821815; c=relaxed/simple;
	bh=85KK7wkCwNmdLAOBeMre2tVgm/LV27OYB+W4Cy2RcKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dpAHebY6BmmnniYLe96gWsTeTqaEZS7iWYpEZqe2aF9hJal69jvoDYV7stoGA3IyDMnzWbauLwOh5oUaVRSrdbrAvYkOW+yrXtrB3Ew4EhTJVmRuVVlfFR3xrTDLWfEfrOs475HQhSvOXdT6RoxY7WjQ3iDq9hW8hHXwcEJ+1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=msW3Zqk0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d96054375so299994f8f.2
        for <linux-nfs@vger.kernel.org>; Sat, 04 May 2024 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714821812; x=1715426612; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU6EIZcy3cHDPH2EvXHMOnA6gxH7VVwXwXFZuCsTmJQ=;
        b=msW3Zqk01qZqsenNm5G3iUW6lyXA6C1OxnG9R7NCh1vN/sJcqQxMl/GdnU6aeiQsBe
         +V4EH168D7wTubothIE3pgPWIlRHilwjw0cHNFWmEB7p/AM8bjUViUA77r2UDeH8KEoe
         oAqBy+RBnn82j2vBeIXobgFPI0Rv5syS0+/V9ZqNh/WjQv5jxl0ysTDlj5ls4U7yrTYE
         XT5PwuxNK0j0HCEypO/Bc31bSG53BGOagrwlLU4ky+6pXVt7uj4xIC7FQBqJNcBpe2km
         FOj82O2hREKny6E/nWHSRc7w8Cn2WlcwX4kwT96OXdT8LSuq/iW4JtADflIj4/N8/ltu
         40Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821812; x=1715426612;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qU6EIZcy3cHDPH2EvXHMOnA6gxH7VVwXwXFZuCsTmJQ=;
        b=iEJzibbvgC8mp8Tq7rM3zKenomO5coz0IeOtTroTCUFUqP5O2ogyyCF3QdLFlZW+wy
         A1Zp+NRilzeUN04oxS38v6O4ea5P4Xy94GTrXMBgy4UjSBOVsGdqZ76pruu7TXPcdf1W
         n58hIF0IHc+EIQPFtjuq+TPUXhigcadqe6ycqVVw43ZW2G+lBQ4Xy9o7tBUoFqGMaJKc
         jKzPefTnq9irxbNwXQ22AiT2s/U3WnUJD3cPAwKBTqM6XaKk6llDkQ7J65G3DuHOMUOC
         /G/m/troXPof+6uoHjl8ZJJ2G/x2nnP6O6nB3G8ycQOw9aO6onbMSjfHxVKanIXA19pB
         ws+g==
X-Gm-Message-State: AOJu0YxBdjjrrAgxFYOZLEt1uz3hx7Zt9P1QqK4Qreioghaara2KUGVT
	iWYM/Wx4d1AsrmuIRjUoaVHzqrLk1+ds367hJ6pkJQZMP36J6/C/QsX8CFa9OoyadVr0XaQ0QxE
	K
X-Google-Smtp-Source: AGHT+IEmbL6Hsq501ALhZIkxrNYcM5wMuNjCaHO45GJwKwwZblpGg7ljBIJg7Tzal1ACeoauqUF1jQ==
X-Received: by 2002:a5d:5045:0:b0:34c:b0bc:157 with SMTP id h5-20020a5d5045000000b0034cb0bc0157mr3856688wrt.47.1714821812347;
        Sat, 04 May 2024 04:23:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4691000000b0034da966c3d8sm5977360wrq.16.2024.05.04.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:23:32 -0700 (PDT)
Date: Sat, 4 May 2024 14:23:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] SUNRPC: Fix svcauth_gss_proxy_init()
Message-ID: <4d92f9a7-a278-4d61-9804-f6bc7cd7963a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chuck Lever,

Commit 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()") from Oct
24, 2019 (linux-next), leads to the following Smatch static checker
warning:

	net/sunrpc/auth_gss/svcauth_gss.c:1039 gss_free_in_token_pages()
	warn: iterator 'i' not incremented

net/sunrpc/auth_gss/svcauth_gss.c
    1034 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
    1035 {
    1036         u32 inlen;
    1037         int i;
    1038 
--> 1039         i = 0;
    1040         inlen = in_token->page_len;
    1041         while (inlen) {
    1042                 if (in_token->pages[i])
    1043                         put_page(in_token->pages[i]);
                                                          ^
This puts page zero over and over.

    1044                 inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
    1045         }
    1046 
    1047         kfree(in_token->pages);
    1048         in_token->pages = NULL;
    1049 }

regards,
dan carpenter


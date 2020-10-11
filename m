Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEA28A9AC
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgJKTeV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Oct 2020 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJKTeU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Oct 2020 15:34:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCAC0613CE
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 12:34:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y12so11195315wrp.6
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CVi85Yq5zz3Ss/lYQdRa5yGz7LIWw5/6uI/E/HT0oks=;
        b=r+9bBgVULRM6x3JNBOsx4woRd6v0qcTa19wYUvjJTz9LYpkD/OvlzxGdQo+07GCOYw
         VuWQmFPVi5/lWGqMi3MBrvRyZBxi82xiUb4V9Q6IPT9TsTdbmsbC0cCTcSP4HIb2YcQr
         BjFI1qfbIna08JWNHE/g2Eki/mS5qpxOnOQI9R38ast+MpqO8TnLd4lDk3Fk0TtXhm3l
         e71DohOjZM/PFHfEm5CntAZbMi3W8lsPnTOlkAu3WCPpiG52KAAPQZVsrZuUzaBorvaA
         /+9xgsLpoRffhk0f5nKWYxeR9boXJFFeO1eN0Mq5nKR9OAkJU1inxH5U+0WQdDfI5N57
         4PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CVi85Yq5zz3Ss/lYQdRa5yGz7LIWw5/6uI/E/HT0oks=;
        b=KBzS5yDceSScdSHnuqz+/XoVQpxD8givTKqeyqrw1QI5Xo5J9HpiVO5PsvquG+M/sk
         5td9Am/FJRlj8Yzzvi6axDy5Eq6N7S+BoIVDixLFbD1GZSiqPAeJcDb/aiMCsY+cKkun
         3WXyxGqArZf58bzTW1VOt9K2h0oanVUP+9BmGPC5UylZiMJbdcYnzWSoBFTYkCCRdjch
         F2zmqP5xNn1rBuH/cXLtwSz+WDoZ6eOpXDY2bTfE6twX6BSF2TMg2IiqL3KiUvkIde8w
         YeOXG6GwqZDWjynuII76+MQxizlmGVp0gmsSpQgP/Yi2UTtsgdRkzODitfSQBvX5eV5c
         5jmg==
X-Gm-Message-State: AOAM530GcmzTXRTNu9vCWPheJI7hypRqpmIqWMmrIfixZRIUlm71ZyW0
        qxXdIbFSqshAKHmUaap8fdqgBK4akpL7XCjY
X-Google-Smtp-Source: ABdhPJwi9/du/4FqVod3SIp4ho7XFdNXHPoBeLhgF3kQfFrLWv+9RZHgq8TiVOvQXFq0wutuqmNJcQ==
X-Received: by 2002:adf:814f:: with SMTP id 73mr6243841wrm.174.1602444858691;
        Sun, 11 Oct 2020 12:34:18 -0700 (PDT)
Received: from [192.168.50.190] ([194.158.213.176])
        by smtp.gmail.com with ESMTPSA id g83sm20414522wmf.15.2020.10.11.12.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 12:34:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] net/sunrpc: Fix return value for sysctl sunrpc.transports
From:   Artur Molchanov <arturmolchanov@gmail.com>
In-Reply-To: <635CFB46-6C1B-4C7A-9BD6-7B26E6AD022F@gmail.com>
Date:   Sun, 11 Oct 2020 22:34:17 +0300
Cc:     bfields@fieldses.org, chuck.lever@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A211941-9BED-4CC3-B7F8-D97A897A44C9@gmail.com>
References: <635CFB46-6C1B-4C7A-9BD6-7B26E6AD022F@gmail.com>
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add maintainers.


Artur Molchanov

> 11 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., =D0=B2 22:28, Artur Molchanov =
<arturmolchanov@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
> Fix returning value for sysctl sunrpc.transports.
>=20
> Without this fix sysctl returns random garbage for this sysctl key.
>=20
> Signed-off-by: Artur Molchanov <arturmolchanov@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> net/sunrpc/sysctl.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index 999eee1ed61c..1edcecef23dc 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -70,7 +70,8 @@ static int proc_do_xprt(struct ctl_table *table, int =
write,
> 		return 0;
> 	}
> 	len =3D svc_print_xprts(tmpbuf, sizeof(tmpbuf));
> -	return memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, =
len);
> +	*lenp =3D memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, =
len);
> +	return 0;
> }
>=20
> static int
> --=20
> 2.20.1
>=20
>=20


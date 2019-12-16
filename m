Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C89121878
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfLPSns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:43:48 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36273 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfLPSnp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 13:43:45 -0500
Received: by mail-wm1-f51.google.com with SMTP id p17so415951wma.1;
        Mon, 16 Dec 2019 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=elMrRXgYjqqcDW9HgDULCgtrVHwGmK3nW7zi1Cteouw=;
        b=rEz8EjCX4+egOtQuj+esnwBDzNYFQw+/f2eFCoub7+q7H5XKLmpMhRffMCUFPtcGyh
         kA6TbkuepdeYJ2tNCzbfX2HuoZ6yhaNMElABBrkjuEx8zwjaG6H7YovqgQbIqeexR76Q
         +3A2bmDpHT5oDpFli85QJ0okyEkWu7vivrfBVrkIeAX9UhrCKoSmMCQxONqn5lO49gM3
         Se+S+NwphaS459qLNDRBAat1LxVnuQI66Uc49O+Sy/0PuIrc+cwFeco413PAUdg2iSHf
         GV3yJBdg6Ig2rmS+++de2xoDJBxyzMp4yrjjxLLaeBQVA4uajlnuWHC1UnogC7Xv4CXa
         LreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=elMrRXgYjqqcDW9HgDULCgtrVHwGmK3nW7zi1Cteouw=;
        b=BPbpv5w8yy7uBz4+FO3cbJ4bDQjpZtRJl2184zbFeXe5c+YcNLB/nvw34p9YggnURh
         mWMYZQb8vyrc8NkH7f2EAF8zVo/tn4HnOgoweOdPIGSvbSBkxmyTTOX9UNvlS/z8yFPW
         5cc7w4jtpZRUb2SFOTkxxQhLDkKPPILBwa+Ws2jIARKxJzcq9IktnE/TY4B3TpvdRyDj
         F0Bs5kiF6Szy52t+2vI/22Jc/7L2jpBoYdMoJOFO7ynL9FMziUx+QGhlXyWGpZkW4QC0
         ZGOpwPRn9k0iKnI1nTp/hWE5GjZPntyW8qMqbW5ugBMnMG9gXbOn1TOx6aa+5bV7vA3Y
         XFug==
X-Gm-Message-State: APjAAAW2zhFd/9Ak821Nd/srrXLORhlkeeIHK0Iek1MaENuzqyqKRQM8
        XsP/f2nwqUZiAP/FkYdjkXsecZL5XcI=
X-Google-Smtp-Source: APXvYqxXXptPKJYglwJxC4E3WNy9hSVCs5w+F2lnKPKfu6JxOvlfpmv4Ehi1E1v8b0PNi0GWmlX3Pg==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr461348wmc.168.1576521823232;
        Mon, 16 Dec 2019 10:43:43 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id u8sm285198wmm.15.2019.12.16.10.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:43:42 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        <linux-nfs@vger.kernel.org>
Cc:     <anna.schumaker@netapp.com>, <linux-kernel@vger.kernel.org>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com> <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
In-Reply-To: <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
Subject: RE: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 16 Dec 2019 18:43:42 -0000
Message-ID: <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkbnQjyymuSgNjdVHy4DQRhOG+0gINBlEqpw88FDA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> From: Trond Myklebust <trondmy@hammerspace.com>=20
...
>NACK. The above argument only applies to legacy minor version 0 setups, =
and does not apply to NFSv4.1 or newer.

Correct. However many sites still use v4.0.


Best regards,
 Robert Milkowski


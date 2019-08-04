Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7153180C46
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2019 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfHDUDQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Aug 2019 16:03:16 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46294 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDUDQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Aug 2019 16:03:16 -0400
Received: by mail-wr1-f52.google.com with SMTP id z1so82282906wru.13
        for <linux-nfs@vger.kernel.org>; Sun, 04 Aug 2019 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc-de.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ap3WDmRiWEqKlbc8pNF+pTrChQ15l4ZxeaQBowUnCWk=;
        b=0zOENhNZoM+J7HsbqKlpHYf0CbzRl8LJhdN/wxTBM6h2O0cpn0iC1AB5/4oehpZmjA
         1uI3XSLyhZ1jJqu0V7Do2AgfF/hvRRQ4f+leC6IooTXG4NDXuwdbfaoLMOXw027yOTZK
         z4MB0j6M34qBNivotteQFBsDhWiQUxDmp11mXhkb0WemhpxSc31gpl9S7mkQ8l3c25Kd
         T/iymUZJlQ9Lu3Tgn1VnNsduIWIFjLb159/RHWhHIZaorHhrrs1dByVA9V5Qhdhv7I9L
         IG4sKg0U3x/K3wBXJJHQknZLLqQQrLl85wysRELFnyIr+z54yiGyHrfyckJ4hIY6aspE
         VqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ap3WDmRiWEqKlbc8pNF+pTrChQ15l4ZxeaQBowUnCWk=;
        b=nLkE9NJAmJ+O6oFbdkkx8RqjPS3vt7+OiGI2o6wmVT1+ekQKH5jY8RXQDrcpc2rzRu
         to4+HdNcSvfzhImjAI+ZrJ0LhqxfNsUlnQ7wiMU9EyQ0lzTBniYlkA3a8hcY/Azz5Q9c
         +EC7Tw8cmjiIQ6aleW8pePiIk2lxZESSmGO4j67yW9PK1h3kSzR7mWFmFmg5lUpxEdWF
         J1C2d0VN7BNQgpCcr3xc0AqspcpIScspD0/xIDVU1AijUHjnSgKQ/H4klMVznMnXLMG1
         Op5yZzMEaxDPCv0GwdcDvLZ+aSRtMvZg/xQjrUNsUCQJ5EM68m15MvalTZYP+h5j7g+L
         elyw==
X-Gm-Message-State: APjAAAUjW80zlt5nND8/4ywq9gDZkDr71LAQOEI5PYEs9kSGWVccaJdk
        eMBxJcAl7k2Vj230l4kWSv9yFOho+m6tnvNDGstE48PcDcyWQLBHx8S8pDvRhBiLdy+6tyO9yVg
        FBKzRM584XSxNgicJNeg=
X-Google-Smtp-Source: APXvYqz/mHrfEzSuUv1nfltrNTcZLX/ScA9B/VK24UHrz8IESEEyrMCzyuUUWXmmLGk+pTpsbgDBMw==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr77379557wrw.144.1564948993887;
        Sun, 04 Aug 2019 13:03:13 -0700 (PDT)
Received: from ?IPv6:2a02:8070:88af:ff00:3921:1c3:154f:173e? ([2a02:8070:88af:ff00:3921:1c3:154f:173e])
        by smtp.gmail.com with ESMTPSA id a8sm67383670wma.31.2019.08.04.13.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 13:03:13 -0700 (PDT)
Subject: Re: NFS issues
To:     Orion Poplawski <orion@nwra.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <98c9d382-a0ff-99a1-f3c3-90868d6357b7@nwra.com>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Openpgp: preference=signencrypt
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
Message-ID: <0452e7bf-947a-fb2c-6250-7fd49a7c5d7e@puzzle-itc.de>
Date:   Sun, 4 Aug 2019 22:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <98c9d382-a0ff-99a1-f3c3-90868d6357b7@nwra.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

Am 03.08.19 um 00:21 schrieb Orion Poplawski:
>    I'm not able to mount a kerberos nfs share from a Ubuntu 18 machine on=
 a
> Fedora 30 machine.  Fedora 29 client works fine.  I get a permission
> denied message.
The tshark output isn't verbose enough to tell for sure whether this is
the cause, but krb5 in Fedora 30 no longer supports various weak
encryption types. I'd recommend to double check the available enctypes
for your server's nfs principal. More details at:
https://fedoraproject.org/wiki/Changes/krb5_crypto_modernization

Kind regards,

Daniel
--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de

--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Jurastr. 27/1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl


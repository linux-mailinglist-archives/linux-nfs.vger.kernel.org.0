Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3597BBEC8C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfIZHaX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 03:30:23 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37425 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfIZHaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Sep 2019 03:30:22 -0400
Received: by mail-wm1-f53.google.com with SMTP id f22so1356560wmc.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Sep 2019 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc-de.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B97CU+U4gCWkiPiGix3ZktM518TkhwXI+KNIuC9KGj4=;
        b=YQ791X3d3rLVyFXfRuWfnED1PIP/vmaGUdT4p/h4wAWulp+5ynv4Pi4uBwLxQC7erG
         NWq+/A4YHxapqHS97PdPkumceqpB1ssMDpYsAC61/G5Q2l2V8YlJ0TAE8iwn83LTEfOw
         xUCrBPBl9ARUFn5JHXaFL4waLlu5gHgWg65VRnHTdkMOmh9GBOThgPbJUbxQDZbpIDFy
         Ym9V001zIXIbn5WqFWyr+549EjsInpxuYsjXkZ709FwwnZ2lKR5gCXvc1BjddDYdQTYt
         aEkngAN7KWwBRlcqdMSeZG5fr1vkQLzF9A7vzt906n5g8Vyn5SiiEX4eoQeGasc5YAjz
         L33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B97CU+U4gCWkiPiGix3ZktM518TkhwXI+KNIuC9KGj4=;
        b=s4FxHLMpzY2dxLayomgLJ6p3XyA/tA1taEnwaxFCerptcwSYYkpcZ7Wckh1e7jGnbg
         I88XHDpxpU5Dih6dQs9MI5f63kdNTR+cJfN1SMTUYEeAv1Oc7bI9pYIxLM22SgK3j408
         ICx+5cVqIAlUdbloh32np9WJ5Pctsa4yGz3m3DTc9nc054Humu0t5+5b5Mo01uNnmBl4
         WiAe2+h/Cvwzresa93+LWE6F33Zo7Pd6oNq5PoxKx4aMV64Z51uuaXRBw38Fby92Y1sk
         WG/CO2bFuE1ULIUSuTgQ50VHn1/OT+Dv47zqTVxvo7X2T0JZdFHtUBkVU8nZudMfY5az
         0i7w==
X-Gm-Message-State: APjAAAWwWME/9EPi+2cJbCFcUWZUvBkYc0RWtQIJk9U/PGekQHaX8hvC
        8HbRVxQRsqSR9wxxbrqA+1rZzPJP/kFaAI2wVNYcJuGSkYAUP7cNlk7VH2gTYjHagPc4VIH7ojv
        AtPgWuhGH4jPbewD16Ns=
X-Google-Smtp-Source: APXvYqweFXQfVCM4V0keV1qO4fjyng3yTQqySW5SbjUTxBC2eRp1O/YPsBVgQUDh0taMyB3aD1Qf6w==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr1735685wmd.29.1569483019340;
        Thu, 26 Sep 2019 00:30:19 -0700 (PDT)
Received: from ?IPv6:2a02:8070:88af:ff00:e5fc:df11:42fa:8f89? ([2a02:8070:88af:ff00:e5fc:df11:42fa:8f89])
        by smtp.gmail.com with ESMTPSA id z1sm2946943wre.40.2019.09.26.00.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:30:18 -0700 (PDT)
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
To:     Kevin Vasko <kvasko@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
 <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Openpgp: preference=signencrypt
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
Message-ID: <d999fc1a-dcc6-b3c3-c8e5-e07f9b5523c2@puzzle-itc.de>
Date:   Thu, 26 Sep 2019 09:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

Am 25.09.19 um 20:44 schrieb Kevin Vasko:
> When should the NFS server be sending a packet to the Kerberos server
> to validate the write? Or should it be? I did do packet capture on the
> Unity box but I don=E2=80=99t see anything really useful regarding Kerber=
os
> authentication. What should I be looking for in the packet traces to
> look for the authentication packets?
You shouldn't see any direct communication between the NFS server and
the KDC. All information is passed indirectly via the NFS client, and
used to establish a GSS context during the initial handshake. In other
words, in your setup, if you see encrypted packets on the wire, Kerberos
has done its job already, and the errors you're seeing are unlikely to
be intrinsic to Kerberos itself, but rather caused by side-effects.

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


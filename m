Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18D4EE21
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2019 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFURtA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 13:49:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFURtA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jun 2019 13:49:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so7421725wrv.2
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc-de.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=+RdpHOSGZIWy2in3Oqe2p/I0RT8/l3tbUejo3fYqKlk=;
        b=Lzqg6olb2OQvt3Z94WGLgrQ4Jmr0dW8c4xrlJB758syTtvN0WA5H6W3C4B7HFEEtBZ
         zYJWIZGzQILGkaCxuj5p/yE3jD3ZIBXaK5niiIm0yx7y9dTEUmyjkKynkbDq/mGQWdTL
         njimHEOVBpi2W0O3J0xYxToGvTOZ4sE8kItU/ZGD8nNFc/GhcEZe4J/4wgSXXkRqGKrR
         qlPPZdiy8iuJyxFshv6MTA2dhYBV2XD04Bydgv/0w1D6E4X0io3uv1NrQzl54F9Kszbh
         I8lgeo9uOOv//HectVKjXW9z8eJmJsUuwsL//RMeO16PSd/CwVKh9PDBeG4FXMs8R9kZ
         jucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=+RdpHOSGZIWy2in3Oqe2p/I0RT8/l3tbUejo3fYqKlk=;
        b=WyFL6n+03kRdQz3H2674jLrKJSPfVfMiDB8xuin9wArG2pGF9/uBC5x4Cjr+1aLXaH
         ClaF1ixZh418YdHpJ0EhXiEZkXJOSKprtCnT3Iy/+yaY9ZAIu0oAUKxCFvNoqwyM0Fwr
         hmTxpw/qSbDSHqsVldtHJu27tMD3yJB4cxO3u8FBgEE9+39Ijtd8uS91hgvSun3KUWrm
         ogh3dGiBN/PuU5QAGl/ApmkZVQu3K218B/1QI2JD3u+Q7oI/YfvdM+Lhgo6p7tnkFGHJ
         483lNmIbCrAacUL0A75QuLo/Exu+cIrNQciZ+zJQ3Ow5u3MI/8PIuZpAsJmmHYcz3kpL
         SBAw==
X-Gm-Message-State: APjAAAWfCMkGho0cIDnP+6zxOSh9BhcSBqvDlg/S1vY1QzZ2Zwm5DsT6
        Iz3pbRj4Zgd2usCJlXc63l4lx9SsHDP5dyqKnkdrku6s4VDDJePA+ikcHI8zTmsXCmvcJbWzlsy
        vcI/2xdMYO3O5lpET7qE=
X-Google-Smtp-Source: APXvYqzUdynthrP2lLItk40md5gkiaUGc2g4FgNbKoYKSlXW9BTuyqsAXb+P3oYnLsIhgeQ7gtdsrw==
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr4647961wrn.342.1561139336875;
        Fri, 21 Jun 2019 10:48:56 -0700 (PDT)
Received: from [10.3.2.68] (b2b-94-79-142-242.unitymedia.biz. [94.79.142.242])
        by smtp.gmail.com with ESMTPSA id 32sm5786456wra.35.2019.06.21.10.48.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 10:48:56 -0700 (PDT)
To:     linux-nfs@vger.kernel.org
From:   Daniel Kobras <kobras@puzzle-itc.de>
Subject: Backport of "false retries" patch?
Openpgp: preference=signencrypt
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 mQGNBFuyIr8BDADfcwWSZafsIOyivFu+Bh3ynelaKS35BuF43EfZmmCmAKzpVrkqo0vYpWb+
 GKn8wyyy+Z89BGvWjMmGQ5tUzIF+2cGgc3SoAeqSOY0CkUPC6ea0rKA/02LiEJR3ScUx5QU9
 uz5H0Y7Xcj0MnqLFw6poZmZqVJ6i0YYNYB0/vtrsmZgRdbkCxq+PINdnCAva9ROkiOwW6iyy
 nmejJETfsy5wIuiVPJ/SyTtnQuBgGvESVzW46JRZS8+aD9PLip/nn0buJCQHZADswMnn62vV
 3fNDCnPFo3z5c//jKm+0MesGEBNtdNdHdLyQy9HizvCE7zpV4HVhDGo8FV9JHReWRb4zv7Cc
 6Ro3kKP7XTdEs1/qxxMtJakW+VY19tS+qFR9C4+PoaeK0/RS7GeI5SMxTHVI2xCkMwG1nNWB
 aZ14XDH1ieXjqQKQr/TCcNbfeZAXO021oqhUN6YKH0H6Iywu7Mos9syqCxFZ6KRYhKaZgJzP
 Jlb6iTcDyFZRbRldOnQiKkEAEQEAAbQxRGFuaWVsIEtvYnJhcyAoUHV6emxlIElUQykgPGtv
 YnJhc0BwdXp6bGUtaXRjLmRlPokBzgQTAQoAOBYhBM3oc+2tF4TjZ5+mipqV0zLLbB3XBQJb
 siK/AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJqV0zLLbB3XE1kMAIlngQYG6ufb
 sSPWbK+mqb9cvYkJrQkgdyNNMHd48MVBWMBq89ycfVnQi0DOzRNqXl6sX/dZQnb/ThWEDoFW
 wvKee2onXGGYVrAf3p1RRFxO1laKXeSECSJE4bru0Lo/mU4tnxOAa+3ugirgIpgvw19zN/Ic
 P9nnlFFyFoLecnc/jUN7BCNmCpjYsregRoKRBT68FGISFEwot2ut4IvP1u6V01JcMpDTtLKs
 u3QxbIkfkVIoyfVGZjWbFhtzl8qRE6Ug7esUHsBEsjvpb5OE9XCwHACn3c8yScKk7xI9dpXt
 bxIIokCJHMZBxO1Q7CUuGYGtAgb2k++/Wh5FxqDTkVglf2UH0nN5B03Sike8TDmZwW59iTiV
 r8sBAsKDizSzTzOESi7f3lcG90anNHf8oLBeMfzfUQZNypneZ/8R7CKzr6msICKhqrR8F9Ed
 889RusI3CPb10OLDRBW4d19nTC5Hyvk4+7vtcenY8g5hGeqLHUgGn28rcK+qkjKr922HU7kB
 jQRbsiK/AQwAxUDhTjEPV9kluZ/Mo/B7Sq8D2aGzfiTQm1c2t5I8BrCbOIQr+t5p1i6wsbUw
 SXahmnHzqUSdLs62aT+i25RsUBMpplYepG66zT5q+7YoBzsh6Sl4zchVTAsDSpUhGFkSZ9mh
 53G9Y3hbv36ROIYJOisWx8KdCG/HFjC8GaWDT5vgvUUL8u90qDXaot5VZXz5RP8+Y2LAfs1R
 Ys/9vd9R+93rDLfceDxDjWiXgUXMhywB8ZzC8ulEwWkzFniWQA09g1+w/9/zhTxD/obCCqQW
 cFhPvZAM7GV4Shx8VhKrsSqwZufVY0d6oA5rB16j/o2lw/2SMOVyZodj8ErwMTYsWsIUt4iG
 XEu0STSrihGz59YimfdHxKg9sFgwD43JcM3+2pXRSE3Q4oazr3TnyIT/dtlNbjtQOjT7apy9
 xZG7kjjvbxjWBkdbmNCNG4te+ueT4Hi/HF5Yw/0xNeOq4WtAT8nGxOLVGLToqugb2P6nKXjF
 0BDJu8S42/jSw4XByNsHABEBAAGJAbYEGAEKACAWIQTN6HPtrReE42efpoqaldMyy2wd1wUC
 W7IivwIbDAAKCRCaldMyy2wd12i4DACUIrpZZqCFVD/jngeYexLci/lmNIUh+pnw/1sI15O+
 N4T7ISCUGLvO7ZFO1qCcLC/UrYxQD+qgBnmQ9mRHXFSiEXcTLQG9QB8h/uP/2ZqhZVjWLdZS
 NFVQBct2etq5NB+z484CT5PhYcpHMzWF8DwwoxqlGxd8MRZ4IEu5Gaa8ZYagZQvSRn/82y6j
 svvBhMidgy6FphmxOwzFgf9EmAToDTJ5Kp5250C/XU9YrPIlg6ALAI5iFlQf5NJIG1dnV3wJ
 xSUgDrMtHpfzP0eTFskimusVtsZmsA9SRyny1fiySsl9xm6bOtwmfmSgK1pQznTg5mMHKsgy
 m66zlacn8OBoZ16acBmNGZL2Du5UUlxsFDGgGNdiXwomLkEhtpPJZC4230d2ngQqLzfBA9CH
 orAjkyCQkC4vNM8gadJcCEmNW8jxQAFAEypFu9JewCA8DiPOIU2xPw27ocZVPuRQIwiAuF3Z
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
Message-ID: <e173572c-97ba-100c-e251-5ff2c4211e62@puzzle-itc.de>
Date:   Fri, 21 Jun 2019 19:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

Debugging a long-standing NFS problem that kept causing application
stalls and required frequent server reboots, we've identified symptoms
very similar to what's described in the "false retries" patch in
http://git.linux-nfs.org/?p=3Dtrondmy/linux-nfs.git;a=3Dcommit;h=3D3453d570=
8b33efe76f40eca1c0ed60923094b971.
Unlike the original report
(https://www.spinics.net/lists/linux-nfs/msg71508.html), we've seen this
issue trigger with older kernels than 4.20, eg. with Ubuntu's standard
and hwe kernels in its LTS releases.

Testing now with a vanilla 5.1 kernel that got the patch merged, has
been aggravated by an unrelated NFS regression
(https://lkml.org/lkml/2019/5/29/772) and is therefore still ongoing,
but looks promising so far.

As far as I can tell, the patch has only been merged for 5.1 and up.
Given that the bug seems to affect more systems than originally
reported, would you deem it appropriate for inclusion into some of the
older -stable trees?

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


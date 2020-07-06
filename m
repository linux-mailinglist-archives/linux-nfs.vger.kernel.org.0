Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC2215CAA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgGFRIV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgGFRIU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 13:08:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39FDC061755
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 10:08:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j4so39525418wrp.10
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2020 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwVHLonV7fEVRJBhUxBkfRuwRu68TPCsz5eTKT71KNc=;
        b=HFMjRggLJcrSTlsdcD84TRsNZ7hWNC8ne9KW3wHyM/ln6KRc7tL3lbqlixQMOjKoXo
         avW8+3esIcHglk+Jbset4zBig0RTPF2dQwTE+LPjwnPWHcfVwAf6/i/xk7uiHpdRa6zS
         zfCFlR17bbNbDJU5twy/1TE8cYA9DHzH5u2Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZwVHLonV7fEVRJBhUxBkfRuwRu68TPCsz5eTKT71KNc=;
        b=PoUinI++YcpFk7YKo6e6l3wE1IokiMBVD0//SMuE/9Z9rQ0GmrC1kggVLnpZubts5l
         W5izvoyvMJ3/923xnU+QHExhYqXkyFBy14PUo7I4f6kglEwDxflxQGwT6n8YwHiYY7Mr
         WCV/ELE5oQuor2RpFOJtZt94hImFutPziGwK9ym7N8+ws79RvP5rdQEeJcthzXtCxsBw
         69zlsau5mVpfblkA2KbGMRNHU/BZ9UcjQ6XITNq+nGZkGD58MzAAsWaL7PMBzpfXDrk/
         grmIuLumcW4+Fc5PjSSTGBvBkPY7mUKZ4ZNkpc5fYsX2n7cyD9R0VI3IoEHJRqFot1Qc
         7/xA==
X-Gm-Message-State: AOAM532o4PnSCdH8cm6Y1iKPl3Fx0cLbpDX7G+6wkwSQ602gL1eYpN9k
        xPfUuoEAPauq1cxHeb/XjocCpc6dYWxFa51HNbKi26Hf9Njlyw+QylxqiY3XeuJtvMe1wARkV5y
        Mys/m6kXYlke6r8sqots=
X-Google-Smtp-Source: ABdhPJxJX0RX1+taawMy1fd2eGsG8LAlcNQK0R68RUeLO1TVv709i8jP+F1AxVXHQWvcY9vAp+gVdA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr49859352wra.348.1594055298250;
        Mon, 06 Jul 2020 10:08:18 -0700 (PDT)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:8881:ba00:c37:9d7f:e3e3:fec4])
        by smtp.gmail.com with ESMTPSA id p17sm69592wma.47.2020.07.06.10.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 10:08:17 -0700 (PDT)
Subject: Re: Multiprotocol File Sharing via NFSv4 and Samba
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
Message-ID: <67e6b3a6-faba-161e-c987-b7d179cf36fb@puzzle-itc.de>
Date:   Mon, 6 Jul 2020 19:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

Am 02.07.20 um 20:04 schrieb Kraus, Sebastian:
> are there any non-commercial solutions (apart from solutions like Dell EM=
C, IBM and NetApp) around that allow to simultaneously access the same file=
 system via NFSv4 and Samba exports in a (nearly) non-conflicting manner, e=
specially w.r.t. to NFSv4/Windows ACL incompatibilities?

You seem to anticipate cross-platform incompatibilities, but mind that
using NFSv4+ACLs on Linux is a problem all by itself. Essentially all of
Linux userland is ignorant about NFSv4 ACLs, so even with basic tasks
one tends to risk subtle breakage. Note that it's a client-side issue
that also affects the cited commercial servers.

To illustrate the point, just try the following sequence of commands on
an arbitrary v4 mount on a Linux client:

  % touch aclfile
  % chmod 644 aclfile
  % nfs4_setfacl -a A::otheruser@example.org:RW aclfile
  % nfs4_getfacl aclfile

  # file: aclfile
  A::OWNER@:rwatTcCy
  A::otheruser@example.org:rwatcy
  A::GROUP@:rtcy
  A::EVERYONE@:rtcy

  % cp -p aclfile aclfile-copy.v4

If the NFS server and its backing filesystem natively supports NFSv4
ACLs, `cp -p` will 'just' lose the ACLs that don't correspond to mapped
mode bits. If they're mapped to Posix ACLs, it's even worse, and the cp
command that was supposed to preserve permissions, has also just granted
write access to the group:

  % nfs4_getfacl aclfile-copy.v4

  # file: aclfile-copy.v4
  A::OWNER@:rwatTcCy
  A::GROUP@:rwatcy
  A::EVERYONE@:rtcy

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


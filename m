Return-Path: <linux-nfs+bounces-184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1357FE7C7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 04:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5151C209A8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 03:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2354CB2D;
	Thu, 30 Nov 2023 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcvJsvHv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ECA10C3
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 19:45:10 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fa4e47f6c0so760563fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 19:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701315909; x=1701920709; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uErC8is7vnRxtyQzHHbBmkTlKx1yk+iDwSz1lPFgvo=;
        b=jcvJsvHvycM59O8O4lPY7Mrt4KjipI/EFlWWj4vCFEdwsAlJVNT1sYfh3MBAOYIwCx
         GnzrQAUaagGGInf/q7TwmgLScsCdvp6xdWNZyEHW28mmBADZDimg++of6tu3qB00Uw+6
         067oiSCQQYF39HLi6vKgjU0ji5RpEX0++ORrOv7k67kK+Hoi6LbeBxCCT+PGR6D2PUy+
         87TTnUdJhJ13ewXd/xOTzw4vB+d/8wO0x6Ej6DjZq9xhnyLcxs1KhfOV8ywHnAtDC6SS
         yY6FS58MniF2oGsI6ZaCfjsCFjprvxrXqKoHUEvl6ALnsafMdvc2txIroEecDZ5P3l+M
         E4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701315909; x=1701920709;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uErC8is7vnRxtyQzHHbBmkTlKx1yk+iDwSz1lPFgvo=;
        b=PJEiPGGQdamYMyFrFMDhCMIJwide3LPlncBVAvSq5BnzJ0FAE+BHOz+JfI0JCH4zFQ
         HHBLghqUGjH6z6CTYLL+w/+MsecSOa6i2JgNY6celoYu5dUkRkQyXVOObN59ehtEHnaR
         U47nkcmJ7j/6bMesWyE2lINiMlPDi+xG2cyNx2KLK5/eg+W344wHnfasA41HqRbvk/fR
         CmyJM9faE3FrE9Ewyc/sC5X0Fx29vV8JsRDFRlLOuvBAVd4abpYyuujT8iVEO42sGIyS
         MJY3m7dlWvwWHhBFXJODHNTypTp3bq4JIEqGXI10/IZmU8w2WeAVuWxb32ksPH25/wD+
         N+vg==
X-Gm-Message-State: AOJu0Yyui1TW8WZfvYdpShmE6bDYBRugwXi2xgfrbMxXYli0UtvONCSi
	WB6iNSjvckq32BAym98NYd5UuyOPEH4IBjoWqYHNMHpY
X-Google-Smtp-Source: AGHT+IGXSmGrsiSLo7SughlUWL0RSPx2+hwBsRmKg1yzvyMtPJIQuYe5w+R1W0TV4dmM+GXFeiqNivG/71s3hy164eQ=
X-Received: by 2002:a05:6870:ed86:b0:1fa:1ca3:ced4 with SMTP id
 fz6-20020a056870ed8600b001fa1ca3ced4mr8017530oab.13.1701315909176; Wed, 29
 Nov 2023 19:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
In-Reply-To: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 30 Nov 2023 04:45:01 +0100
Message-ID: <CANH4o6Mu8kDvZTrssVc_Tr1CKkWaUFnZxzdjQNw7-2tmYTTOzw@mail.gmail.com>
Subject: Re: umount.nfs: /mnt: block devices not permitted on fs
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Fri, Nov 24, 2023 at 9:57=E2=80=AFAM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> Hello,
>
> We get a umount.nfs: /mnt: block devices not permitted on fs in a snap
> container on Ubuntu.
>
> Can anyone explain what is going wrong?
>
> Thanks,
> Martin


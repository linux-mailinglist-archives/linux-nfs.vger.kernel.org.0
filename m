Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1729A6F7
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 09:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894668AbgJ0Iv5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 04:51:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509508AbgJ0Iv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 04:51:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id l16so585120eds.3
        for <linux-nfs@vger.kernel.org>; Tue, 27 Oct 2020 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bjD7Z/SNhV2Nlqbx2aancoPc3PMrznW+fnFcgUkUolk=;
        b=tI/j6uB77r6I7d25flTMkxeH94buo0FvhZwMpkFV8TstipTwxKbZM2F1TMX0MQZ+1B
         dm4b48YIlzUH31OMPdz00a/Y3rud6oa4jTHPgUay3/h/iTHtLYPMOJVwUVf7tUDxNRfW
         UkTNT1Vx63MR0Kk3umDXVpAGuctxmAaoG69HXwX8LuH7bAWnEvW2WiQFm3KheOe08Mr/
         wL5PmEhfFPeSeLL4MuSKUaNliVC9up48sZYMpuWHrYkbo1a+pvEWuDr5Pij7xm2ktJ5n
         v+5bPE+uVfuCYs4b86opQHOR2ql8FMrKiZM8/y8JQxrgunPKnWyBlwCABSo7J7EK+CvT
         v2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bjD7Z/SNhV2Nlqbx2aancoPc3PMrznW+fnFcgUkUolk=;
        b=Lo2BoK6kGt8Q27DWNVl1vnt13HKuSh3eGr9xZNF9QnUR8f8CmV8L1X/nazNdTXKAk/
         btJmy23Me4cA/5iS5Bw1BmuEwvxy5FWV3irYKQR5zxElkURusFfLX66by2SNOpe1KNEo
         +54v7C+I2U72VH/L/D992Q+OYqrCfGGane7Qr4kBWIkp7LAsJ4Czsm7bxo68pwE8Tjxi
         qYiySvbX3p5ZLWfz/o/pjHjg2+6lW2iZBA4ZUFCXHirjfAE9B3ovTEafxdSrRN2x9Izx
         7K53l6xHW6VxCV7fDIQsnXm3fvtvPJj34lN1zaVn1NCy/7wd2BknWm6J2toUVIvoZF4n
         nuKA==
X-Gm-Message-State: AOAM530Mx2iPnJpZeZWT0BrLifLcNE/qZU9gF04vFOGjQeGpFyZuyhAZ
        5CAb0aSQLnPQUjPGtBKcKB4=
X-Google-Smtp-Source: ABdhPJyJy+BaDy17Ql64DQAtfq6WMYCFG+8ssnDXipQFybETkgzm78Tw00db47eMlawU61aHD77n0w==
X-Received: by 2002:a05:6402:1298:: with SMTP id w24mr1037318edv.280.1603788715043;
        Tue, 27 Oct 2020 01:51:55 -0700 (PDT)
Received: from [192.168.50.190] ([194.158.213.176])
        by smtp.gmail.com with ESMTPSA id y1sm508741edj.76.2020.10.27.01.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:51:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [bug report] net/sunrpc: Fix return value for sysctl
 sunrpc.transports
From:   Artur Molchanov <arturmolchanov@gmail.com>
In-Reply-To: <20201027083158.GA2533809@mwanda>
Date:   Tue, 27 Oct 2020 11:51:53 +0300
Cc:     linux-nfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0686EA90-655B-4682-9CA8-0C48B29DC685@gmail.com>
References: <20201027083158.GA2533809@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dan,

Please ensure that my patch primarily fixes returning value of the =
function proc_do_xprt().
Before this patch proc_do_xprt() returns output of =
memory_read_from_buffer().
If memory_read_from_buffer() returns non-zero value then output of =
sysctl would remains uninitialized.

If memory_read_from_buffer() can not returns the negative values then we =
could just get rid of the condition.


Artur Molchanov

> 27 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., =D0=B2 11:31, Dan Carpenter =
<dan.carpenter@oracle.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
> Hello Artur Molchanov,
>=20
> The patch c09f56b8f68d: "net/sunrpc: Fix return value for sysctl
> sunrpc.transports" from Oct 12, 2020, leads to the following static
> checker warning:
>=20
> 	net/sunrpc/sysctl.c:75 proc_do_xprt()
> 	warn: unsigned '*lenp' is never less than zero.
>=20
> net/sunrpc/sysctl.c
>    62  static int proc_do_xprt(struct ctl_table *table, int write,
>    63                          void *buffer, size_t *lenp, loff_t =
*ppos)
>    64  {
>    65          char tmpbuf[256];
>    66          size_t len;
>    67 =20
>    68          if ((*ppos && !write) || !*lenp) {
>                              ^^^^^^^
> It's weird that we don't just return -EINVAL for writes or something.
>=20
>    69                  *lenp =3D 0;
>    70                  return 0;
>    71          }
>    72          len =3D svc_print_xprts(tmpbuf, sizeof(tmpbuf));
>    73          *lenp =3D memory_read_from_buffer(buffer, *lenp, ppos, =
tmpbuf, len);
>    74 =20
>    75          if (*lenp < 0) {
>=20
> "*lenp" is unsigned so it can't be less than zero.  =
memory_read_from_buffer()
> only returns an error if ppos is negative but that's impossible =
because
> this is a proc file so negatives are prevented in rw_verify_area().
>=20
> In other words this bug can't affect runtime.
>=20
>    76                  *lenp =3D 0;
>    77                  return -EINVAL;
>    78          }
>    79          return 0;
>    80  }
>=20
> regards,
> dan carpenter


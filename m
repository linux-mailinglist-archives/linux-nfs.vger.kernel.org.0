Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0315E768
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfGCPH1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 11:07:27 -0400
Received: from mout.web.de ([212.227.17.12]:46617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCPH0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562166440;
        bh=W9/Rx4pVvriRi525/LkdxtKOCW5OZ0cvPzvzCejQASk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Ab74CEnKRsGy52uNXfAMqYJf6pnXnWyxgkT06Ocnp4JJ6WWHW9iEduFA+kApZ4WZk
         Re03OoWaEmRAC5twyFboaTYwib8UfQVucCSHQgL2Dzpw06DFofzl/G27YE9tC2U1sZ
         j8otgP7Gl3HG5pwD1G4OXHIxk4Mq6mE07kAPUfhs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1iBjDR3Fd4-00gbhC; Wed, 03
 Jul 2019 17:07:19 +0200
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] NFS: Adjustments for three function implementations
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Date:   Wed, 3 Jul 2019 17:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qVT2UpC7cVPsIWHzOSitNSeQfwN6NGKRYe7oGRVJx/o1hNQcXoC
 2T4szTrnNwG8D6qJUE010XV7OTrcqmUwPXwZLBVAe3Ps+fgrk54cQg5ZhI2F91iv6aYmJNo
 n1iazq1WRGbHqlX+DFV4ec320PCBYFkJUq7Wto3NdnIaS+eO6MjPNn9KMJ40r94t908QxzY
 8+ae7kIqr84qNXLirnWBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YGLNHpA1g34=:ItRf8/2+s64XpPDiQToXtR
 XZD+tS4PafpQCuBccGhvixjpNRuFtT8vAJKTOb2Y6JGXvMM+/XztFO4y702ND6TjKJNhsPXei
 M1s75tZFit0kwO1WalkCYzl+HRpzkVncUEd725Woa7q+6yXfNjC21wNK7nuV0SfdXMNVWgiFs
 rP644DOAFU+d4n+XXSpYs35ELbFLYG6rT5xJVuxT3HE3hDqHVN7kaetgIypLD2558zdvCh1R/
 lXgDAyS14AFRktgupuhMGkGDuO8YRSxujGY/ZmwFwpzUCShMXflZyBFjcfkH7fpqHd9cRAbsM
 vSXwiGMwooQT8T8Sf3ev70icZc0MESHo1Mq+FtioS0EUAARbZlkIGy8FAnm2T3dCDucKPmNCT
 qsKjnwwe70d4uTcfWuleWKpfv8No1PGcpY6dU+iufWPtWrK5QyDhNXQcBkwCqfSc42Jy6ZoFr
 NEYWHIedrm+zZ40NQlu+prTND0tIIoYEU+CzMgOLL4STXHOrMwL6VE08cgYS7hRR4yJ5YMg2o
 5f4Y7lz1VCEj2RhGiAMPvns6tkpg3vKdOm96d3maujeR39Gln5QiiDQLeih6QTYdwTlzCmUap
 oQZJVgnUcjSwWcwE32o5GL9KLs4P/3hzhFnkn6SWKolhuM5EnD9jWif5lkk6CBWqw5e+8orNc
 UpsTLudkWgSeOVx2tbeDyybM+SkKXCOAh5BVVyvi4HHLatYpIEzzo+3fPncaBET0j6HUWQ7eP
 yv2ktDLOaMdAuoAu1yTPBJZKncF8/rESchrGaODQC5anWIgd/nop1Yv/+VbbTFC4z5kfeSQhR
 hywZTMwcQ5+93AIy34PLE8WIW2NtSZA96A2hyHD5KhMZXuQYp+zXyqBy6JrFY48PkH3F7fp0u
 AkU38SbzwSBNWlVFnej7qnPfff6bBPYAY431Y0bf4MUuRKIQmLIaSBOfbM7Cc9F1czWmWEKpM
 FfhEvQXseYku6vcX5BJdTYwoaqmY+BRcgjxaZrjA6c9mPAxs7fQnouQVYLbs3eY8NXqb3zlXu
 wzc02tWBjZcIWLdtyn5rVf/vT+1T+Ug50qjtTurOzGwzcxUDMmZDy0mwJPCW6hnJU5G+27BTv
 lXKTOzEdm6o4oH3S+WOxQ7icUhvL3q+kt8g
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 Jul 2019 17:02:05 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use seq_putc() in nfs_show_stats()
  Replace 16 seq_printf() calls by seq_puts()
  Three function calls less

 fs/nfs/nfs4xdr.c |  5 +----
 fs/nfs/super.c   | 53 ++++++++++++++++++++++++------------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

=2D-
2.22.0


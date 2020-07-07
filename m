Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C098E216D92
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGGNS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 09:18:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727875AbgGGNS5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594127936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cD01teuum4060FVEjE8TJMIgk64qwRy8LU4q2gm8ME=;
        b=UowGk+T9oaFFJnWjCs7U3WjW0cY172DFSWf85XTw/bu7sIuv+PUDGqwIdHnNed8djC7VAs
        5yLq2WKx/FeW7wH5Sm8PIY+dy3P9Fk+Yalfs5b1dFLe71d4X/f4caRH0PGcxPN8/dBZ+ql
        xmj0MD9R0LH6sTq7wGm3vukUTYvm9Lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-op0ZN2DZNVGCzyJ_MRaLlA-1; Tue, 07 Jul 2020 09:18:54 -0400
X-MC-Unique: op0ZN2DZNVGCzyJ_MRaLlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D88128015FA
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2020 13:18:53 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-119-201.rdu2.redhat.com [10.10.119.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54CA679810;
        Tue,  7 Jul 2020 13:18:51 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id C1CB21A023D; Tue,  7 Jul 2020 09:18:50 -0400 (EDT)
Date:   Tue, 7 Jul 2020 09:18:50 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Max Reitz <mreitz@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Testing auto-submounts (crossmnt)
Message-ID: <20200707131850.GQ4452@aion.usersys.redhat.com>
References: <3f2854db-dce9-557d-6812-12febff61916@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f2854db-dce9-557d-6812-12febff61916@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Max,

On Mon, 06 Jul 2020, Max Reitz wrote:

> Hello again,
>=20
> Because I didn=E2=80=99t receive a reply to my question back in April
> (https://www.spinics.net/lists/linux-nfs/msg77401.html), I wanted to
> send a gentle ping just once.  Maybe there is an answer to it yet.
>=20
> I just would like to know whether there are any tests for NFS=E2=80=99s c=
rossmnt
> option.
>=20

AFAIK there are no tests for nohide, crossmnt, or submount (at least not
in cthon, xfstests, nfstest, or ltp).

-Scott

>=20
> Kind regards
>=20
> Max
>=20




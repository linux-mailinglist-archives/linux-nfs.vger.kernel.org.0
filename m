Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAFFFB7E
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2019 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKQTkW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Nov 2019 14:40:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfKQTkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Nov 2019 14:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574019620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKbDlHwnVqgNvTQKKHL++w1APdZeeY5yMgE34pChvEU=;
        b=iEe3sjQXSJ6BwyfhpDVcZN2tPRcwNaMx6i91q+cS69XuYI51Nj6f3DYqwjaEMrqlHxn4wc
        K/gwcECtdSsqhk5DLEtVmw9qk5XtCgojkYVrfD2xeybK54xWl1y3a6J7W//JqVyTYBdelb
        u7eS9bpglXM0JRnWYMPK+X1YoLRO6tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-GkoTLqBHMuqM6UYgNqmt2w-1; Sun, 17 Nov 2019 14:40:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4712D2EDA;
        Sun, 17 Nov 2019 19:40:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F384F600CE;
        Sun, 17 Nov 2019 19:40:16 +0000 (UTC)
Subject: Re: ANNOUNCE: nfs-utils-2.4.2 released.
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <04f375d6-e50a-0b5e-7095-dbc3907bfe23@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fd6a75d4-9b52-9c8f-9ad5-d01340fdb89e@RedHat.com>
Date:   Sun, 17 Nov 2019 14:40:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <04f375d6-e50a-0b5e-7095-dbc3907bfe23@nazar.ca>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GkoTLqBHMuqM6UYgNqmt2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

On 11/17/19 12:47 PM, Doug Nazar wrote:
> This still causes crashes in mountd on 32bit systems without https://marc=
.info/?l=3Dlinux-nfs&m=3D157250894818731&w=3D2
>=20
> mountd: Version 2.4.2 starting
> mountd: auth_unix_ip: inbuf 'nfsd fde2:2b6c:2d24:0021:0000:0000:0000:0050=
'
> mountd: auth_unix_ip: client 0x13cd900 '*'
> mountd: nfsd_fh: inbuf '* 6 \xd1fb45ab77b345d99b09b3217dcdf2ec'
> *** stack smashing detected ***: <unknown> terminated
> Aborted
>=20
> Call chain looks like:
>=20
> get_rootfh=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 utils/mountd/mountd.c
> =C2=A0=C2=A0=C2=A0 check_is_mountpoint=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sup=
port/misc/mountpoint.c
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 nfsd_path_lstat=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 support/misc/nfsd_path.c=C2=A0=C2=A0=C2=A0 *
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 xlstat=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 support/misc/xstat.c=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *
>=20
> where two struct stats are declared on the stack in mountpoint.c without =
including config.h and getting the __USE_FILE_OFFSET64 define, however the =
following two files in the call chain include config.h and get a different =
size struct stat.
>=20
> Also attached are a few printf formating fixes for 32 bit.
My apologies... I did miss this patch in the last release, but the
patch is now committed...=20

I blame the American Halloween... the day the patch was posted! :-)=20
Those darn spooks and goblins of getting in the way!! 8-)=20

steved.


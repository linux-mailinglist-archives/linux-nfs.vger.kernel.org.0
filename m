Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4494216DC1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGNci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 09:32:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgGGNci (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 09:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594128757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=daxLKDaQIRh/j9vDAEMZME8qlzg9gjFhal+V+cSjVSw=;
        b=P6w5LS4pnYfcxB6gyYRKpyApGap/BR60GJJewiAM2N8OBan0JNamHK6BAVGIszIGbf00LK
        4qMAIf4jRezfoNIkz3ZuPSve/YuZBT+dl0SP3il6cpZML76AD4elUqY+B4wFMsypSmMBQY
        IRWsQtJNTc9wqgYW5TKjRLpU83ibUa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-EJ7Xc30UPp68HguTE62GzQ-1; Tue, 07 Jul 2020 09:32:32 -0400
X-MC-Unique: EJ7Xc30UPp68HguTE62GzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E627800414
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2020 13:32:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-68.ams2.redhat.com [10.36.115.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C53B160E3E;
        Tue,  7 Jul 2020 13:32:30 +0000 (UTC)
Subject: Re: Testing auto-submounts (crossmnt)
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <3f2854db-dce9-557d-6812-12febff61916@redhat.com>
 <20200707131850.GQ4452@aion.usersys.redhat.com>
From:   Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <da5ef610-d52b-eb51-eb11-3110e0117be2@redhat.com>
Date:   Tue, 7 Jul 2020 15:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707131850.GQ4452@aion.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AEdWXcjEwoFkf6LnO5QNz0r9qO3I0ArLO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AEdWXcjEwoFkf6LnO5QNz0r9qO3I0ArLO
Content-Type: multipart/mixed; boundary="bcHuONQF09Zsjpe7ACzKiH8GTNUZNeS9L"

--bcHuONQF09Zsjpe7ACzKiH8GTNUZNeS9L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.07.20 15:18, Scott Mayhew wrote:
> Hi Max,
>=20
> On Mon, 06 Jul 2020, Max Reitz wrote:
>=20
>> Hello again,
>>
>> Because I didn=E2=80=99t receive a reply to my question back in April
>> (https://www.spinics.net/lists/linux-nfs/msg77401.html), I wanted to
>> send a gentle ping just once.  Maybe there is an answer to it yet.
>>
>> I just would like to know whether there are any tests for NFS=E2=80=99=
s crossmnt
>> option.
>>
>=20
> AFAIK there are no tests for nohide, crossmnt, or submount (at least no=
t
> in cthon, xfstests, nfstest, or ltp).

Aw, that=E2=80=99s too bad.  Thanks for your response, though!

Max


--bcHuONQF09Zsjpe7ACzKiH8GTNUZNeS9L--

--AEdWXcjEwoFkf6LnO5QNz0r9qO3I0ArLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8EeWwACgkQ9AfbAGHV
z0D+6AgApUWLJsXJW8bJw3N/+5znXL7nyci3pD11fS5jrut8/nVJhsTYlKzh8ZNU
C6bfjsjirAUSl797kOmiaRywwc22jMKGT3thxPfc2vSDIlJbhKBShtncCUlN+vuJ
sF2ah7STiHSgpyl4o8GYBt+gjTN5IFmVxTC7Gn5BEBF4hO6GML5zCBbF6DH9a/dQ
4QIHcy+Onm31FJFCi9YrHeWMeX11kpT4WUjQwTZG5tD4yikIKT6/5xnjB6j0ObLN
XycvE/7D+iQKZYnJ3z9Otgz8XuXrfCoh6oWe9SYM6hCEyyAzxGumM0UYeidFQBFr
nICFMn+XyLorimU/NU83CFjJPbPPmQ==
=n6ip
-----END PGP SIGNATURE-----

--AEdWXcjEwoFkf6LnO5QNz0r9qO3I0ArLO--


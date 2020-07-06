Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA4215A12
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgGFO4C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 10:56:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30885 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgGFO4B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 10:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594047360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=OAgSj0oM6shJeTpdYzLtetbRiSkpWorNMEyO8Ij8Nvc=;
        b=KWfcewxipkiWx3wQHojFXlXtLgA3q2melCgG5Ciryo/0iW6bdSHMW/7lI6HPn1oRUGq1i9
        i3Qq5atJ+2Ng3yJxHRETsPLI9V3Pd805RP3EI9PdzAfo3ugWoFLxYuvO0bHtPbsznIeb1y
        dwRUbW1BeVnwpx1bYd7ppeUTKrJ+Wz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-kxiIKb6OPQinBVMrNIWK6g-1; Mon, 06 Jul 2020 10:55:55 -0400
X-MC-Unique: kxiIKb6OPQinBVMrNIWK6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91A3B8014D7
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 14:55:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-176.ams2.redhat.com [10.36.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3739E5D9D7
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 14:55:54 +0000 (UTC)
To:     linux-nfs@vger.kernel.org
From:   Max Reitz <mreitz@redhat.com>
Subject: Testing auto-submounts (crossmnt)
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
Message-ID: <3f2854db-dce9-557d-6812-12febff61916@redhat.com>
Date:   Mon, 6 Jul 2020 16:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gByEe4KgXGYBhBuLcK7kDNKmneVZq1lef"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gByEe4KgXGYBhBuLcK7kDNKmneVZq1lef
Content-Type: multipart/mixed; boundary="CX9zBS0tkZy0X0NSeyzdfORv0vFZdPv7Q"

--CX9zBS0tkZy0X0NSeyzdfORv0vFZdPv7Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello again,

Because I didn=E2=80=99t receive a reply to my question back in April
(https://www.spinics.net/lists/linux-nfs/msg77401.html), I wanted to
send a gentle ping just once.  Maybe there is an answer to it yet.

I just would like to know whether there are any tests for NFS=E2=80=99s c=
rossmnt
option.


Kind regards

Max


--CX9zBS0tkZy0X0NSeyzdfORv0vFZdPv7Q--

--gByEe4KgXGYBhBuLcK7kDNKmneVZq1lef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8DO3cACgkQ9AfbAGHV
z0C6+wf/YJ3Q6KJmPWl+oD//pk+TOShBL+Lmga79H/rmdhrlDEFolq9+qHb6gdTM
XeU6cHn7lFsXqij2DUxNK1acv3hp9+1hAqK864FI6y9MSJH0XcXFo1YDa3Y/l43t
+x5a93Be6h1n67rw+j3MPMW0QV8mIEtQ8jtETiDabWaMDd5knuglR6O5JYDPTapd
8PfUcwzYI+Dd+1BY1LIL5AgHUToPPB/OEHdoDCjQgyh+tIlD8sNGK3lElSkg+EZ6
znvzRb+qzEA2vEzdGyfEZ8ebYDM6uzm+o3XFRUjw4opQ9KekEl7aAzWN1Xcr5neX
iRtMbLx1bajhEW9xzyusEloKcoJoAg==
=Q3lm
-----END PGP SIGNATURE-----

--gByEe4KgXGYBhBuLcK7kDNKmneVZq1lef--


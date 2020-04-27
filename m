Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF121BA1CC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2020 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0LAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Apr 2020 07:00:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0LAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Apr 2020 07:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587985202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=Z7a2Fb/GgqKLsKLdung2T1u6un/O5fVLJmtiwIOV9jc=;
        b=TYvZAhqxEPqrztXL1kY7zTwvaekfJL00RY8Ell9CsYq3qSCwKmYMONkQKn1hpGs7TkX559
        QUzeqFRTn2rZr8Ms3X2f8fJT+LGdkyTGUiPVLXMVnX9DorFk9zk9P7TsMmMTb4CgPNdhjs
        OUFG6Gs0x6kBN+ZYAH6bsnrJkmgIubY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-2TE088DMNd-_i8QatyfzBA-1; Mon, 27 Apr 2020 07:00:00 -0400
X-MC-Unique: 2TE088DMNd-_i8QatyfzBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B1811005510
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2020 10:59:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07CEA10013A1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2020 10:59:58 +0000 (UTC)
From:   Max Reitz <mreitz@redhat.com>
Subject: Testing auto-submounts
To:     linux-nfs@vger.kernel.org
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
Message-ID: <877990a3-14ea-9c65-c38a-1701cccf504e@redhat.com>
Date:   Mon, 27 Apr 2020 12:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everyone,

Most of this mail may make it seem like it doesn=E2=80=99t concern NFS at=
 all,
so let me get to my question before the explanation on why I=E2=80=99m as=
king it:

Do you happen to have any tests for auto-submounts, i.e. creating
submounts on the client for every crossmount on the server in the
exported directory tree?  I was looking in nfstest.git (and xfstests)
for things like =E2=80=9Csubmount=E2=80=9D, =E2=80=9Ccrossmount=E2=80=9D,=
 or =E2=80=9Cautomount=E2=80=9D, but didn=E2=80=99t
spot anything.

Now, for why I=E2=80=99m asking:

I=E2=80=99m involved in virtio-fs, a way to share directories between VM =
hosts
and guests, using the FUSE protocol.

We have the problem of presenting unique st_dev/st_ino combinations in
the guest for every unique inode on the host.  Right now, we just pass
through the st_ino value from the host, but if you have submounts in the
shared directory, then those st_ino values may collide between different
devices (because the whole tree is just a single mount with a single
st_dev in the guest).

To fix it, we plan on creating an automounted submount in the guest for
every submount on the host, such that every submount has its own st_dev,
so the combination of st_dev/st_ino will remain unique.

This seems similar to what NFS does with the crossmnt option.  Now,
because of course we want to test that everything works, I was wondering
whether there are any such tests for NFS already that we could modify
for virtio-fs to get reasonable coverage.


Thanks a lot and kind regards,

Max


Return-Path: <linux-nfs+bounces-18072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBADD38D34
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 09:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57762301A1C2
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F641ACED5;
	Sat, 17 Jan 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="B1hqUdpV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC63FEF
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768637769; cv=none; b=YVntakQL9wMy4v4m8KJHlycD0fbYW+mrP2AGAnN8uqQ9TZCrpHM6xZEs1GJNZttxYtedYnvlpw1kNJ16nE90w3Yc6ChtVxKJchpdUtXnt2WFmytGGIz9goNUgO1sDRKYUdbWormd0TT4YE2gUZIdbadbGecuMppj2MBw6K1Hjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768637769; c=relaxed/simple;
	bh=huH3W/yOKSmYLgDmVuTGxaqvvQ0R2UrUVhx0xbVzdhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urs6uN4q1abujcB4vt+2dfhw2qDtqkH1t7xtnhCEzpbDSpX+xIJ6DGIMCw4i+idPurEkaK1sbXgwIjaxa95eYVeIHUtuC/zPr7MEsEV11k8mpFGa6A2qNSj5HMzATdU5A9pkEvPzQmv07W4P+qSrq+n1gurFL14lEO4WdCnNHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=B1hqUdpV; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+DyAm22NE/Ps6x896+tEuEEfZt9kA7J78beks28/xlc=;
	b=B1hqUdpVSGxx/sTpjR/HFV3Vwlv4VIov1oK0nFK10aZM4OqC8Z/oTOVED/F5iUjsjJyS6ZwGc
	6JqOVLfAV3Y3bpw11SkSwFGPn4d2MVUuCkw659YsKDdsZr35p+UT985GOguuCLgvPPpAZTMjQAw
	uxqkeVnt+8c9kfxKmDiQl1A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dtTwm6zv3zKm57;
	Sat, 17 Jan 2026 16:12:40 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 094DC40565;
	Sat, 17 Jan 2026 16:16:03 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (7.185.36.143) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 Jan 2026 16:16:02 +0800
Received: from dggpemf500015.china.huawei.com ([7.185.36.143]) by
 dggpemf500015.china.huawei.com ([7.185.36.143]) with mapi id 15.02.1544.011;
 Sat, 17 Jan 2026 16:16:02 +0800
From: "liujian (CE)" <liujian56@huawei.com>
To: Petr Vorel <pvorel@suse.cz>
CC: "ltp@lists.linux.it" <ltp@lists.linux.it>, "andrea.cervesato@suse.com"
	<andrea.cervesato@suse.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, Steve Dickson <SteveD@redhat.com>
Subject: RE: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc validation
Thread-Topic: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc
 validation
Thread-Index: AQHcg2KKsp0GmVN7WEy47qDqaoDbWrVPgqiAgAFhd5A=
Date: Sat, 17 Jan 2026 08:16:02 +0000
Message-ID: <549901d2f1344eb6b4500a6559febc78@huawei.com>
References: <20260112015047.2184003-1-liujian56@huawei.com>
 <20260113122557.GA318506@pevik>
In-Reply-To: <20260113122557.GA318506@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Petr Vorel [mailto:pvorel@suse.cz]
> Sent: Tuesday, January 13, 2026 8:26 PM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: ltp@lists.linux.it; andrea.cervesato@suse.com; linux-nfs@vger.kernel.=
org;
> Steve Dickson <SteveD@redhat.com>
> Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc valid=
ation
>=20
> Hi all,
>=20
> [ Cc Steve and linux-nfs ]
>=20
> > The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
> > rpc_xprt_unregister) was failing due to an invalid fd, which caused
> > libtirpc's internal validation to reject the operation.
> > This change ensures a valid socket fd is created and can pass the
> > validation checks in libtirpc.
>=20
> + I would also like to know more details about the failure (libtirpc
> + version, or
> do you still use Sun RPC from old glibc, distro, arch, ...).
>=20
tested this on Debian 12 and Debian 10.
I observed that the latest libtirpc (1.3.7) code has the same logic.

svcfd_create
----svc_fd_create(fd, sendsize, recvsize);
--------...
--------getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0)
--------...
--------getpeername(fd, (struct sockaddr *)(void *)&ss, &slen)
--------...

The above is some code flow of `svcfd_create()` in libtirpc, where both=20
`getsockname()` and `getpeername()` require the file descriptor (fd) to be=
=20
a valid and connected socket.
Additionally, in glibc, there are no similar operations in `svcfd_create()`=
,=20
so there is no issue for this test case.

> Because while we have some problems with some of these tests, I'm not
> sure if connecting to 127.0.0.1 is a valid approach. And if it is, should=
 it be
> used in more tests? Also rpc_svc_destroy_stress.c and
> rpc_svcfd_create_limits.c use svcfd_create().
>=20
For a UDP socket, connect() does not trigger any message transmission and
should have no other side effects. What do you all think?
However, there are no `rpc_svcfd_create_limits` or `rpc_svc_destroy_stress`=
=20
tests in `runtest/net.rpc_tests`?

> Below are few minor implementation details. First, maybe add a common
> header, with code in the function which would be used? But it can be done
> later (RPC test code is really awful, more duplicity will not make it wor=
se).
>=20
> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> > v2: Fix a compilation error on Alpine.
> >  .../rpc_svc_destroy.c                         | 27 +++++++++++++++++++
> >  .../rpc_svcfd_create.c                        | 26 ++++++++++++++++++
> >  .../rpc_xprt_register.c                       | 25 +++++++++++++++++
> >  .../rpc_xprt_unregister.c                     | 25 +++++++++++++++++
> >  4 files changed, 103 insertions(+)
>=20
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > index 22e560843..b9240ccba 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svc_destroy/rpc_svc_destroy.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_cre
> > +++ atedestroy_svc_destroy/rpc_svc_destroy.c
> > @@ -30,6 +30,12 @@
> >  #include <time.h>
> >  #include <rpc/rpc.h>
>=20
> > +#include <unistd.h>
> > +#include <sys/socket.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
> > +
> >  //Standard define
> >  #define PROCNUM 1
> >  #define VERSNUM 1
> > @@ -43,6 +49,27 @@ int main(void)
> >  	int test_status =3D 1;	//Default test result set to FAILED
> >  	int fd =3D 0;
> >  	SVCXPRT *svcr =3D NULL;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> Maybe fprintf(stderr, ...) or perror()?
>=20
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
>=20
> Maybe just:
> struct sockaddr_in server_addr =3D {0};
> instead of memset() ?
>=20
> > +	server_addr.sin_family =3D AF_INET;
> > +	server_addr.sin_port =3D htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <=3D 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> Funny that all testsuites don't close fd, but not closing single fd is no=
t that
> problematic.
>=20
> Kind regards,
> Petr
>=20
> > +		return test_status;
> > +	}
>=20
> >  	//First of all, create a server
> >  	svcr =3D svcfd_create(fd, 0, 0);
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > index f0d89ba48..ea4418961 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_created
> > estroy_svcfd_create/rpc_svcfd_create.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_cre
> > +++ atedestroy_svcfd_create/rpc_svcfd_create.c
> > @@ -29,6 +29,11 @@
> >  #include <stdlib.h>
> >  #include <time.h>
> >  #include <rpc/rpc.h>
> > +#include <unistd.h>
> > +#include <sys/socket.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
>=20
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -43,6 +48,27 @@ int main(void)
> >  	int test_status =3D 1;	//Default test result set to FAILED
> >  	int fd =3D 0;
> >  	SVCXPRT *svcr =3D NULL;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family =3D AF_INET;
> > +	server_addr.sin_port =3D htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <=3D 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
>=20
> >  	//create a server
> >  	svcr =3D svcfd_create(fd, 0, 0);
> > diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > index b10a1ce5e..a40dad7fe 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_register/rpc_xprt_register.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_reg
> > +++ unreg_xprt_register/rpc_xprt_register.c
> > @@ -31,6 +31,10 @@
> >  #include <rpc/rpc.h>
> >  #include <sys/types.h>
> >  #include <sys/socket.h>
> > +#include <unistd.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
>=20
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -45,6 +49,27 @@ int main(void)
> >  	int test_status =3D 1;	//Default test result set to FAILED
> >  	SVCXPRT *svcr =3D NULL;
> >  	int fd =3D 0;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family =3D AF_INET;
> > +	server_addr.sin_port =3D htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <=3D 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
>=20
> >  	//create a server
> >  	svcr =3D svcfd_create(fd, 1024, 1024); diff --git
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > index 3b6130eaa..5ac51de41 100644
> > ---
> > a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunre
> > g_xprt_unregister/rpc_xprt_unregister.c
> > +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_reg
> > +++ unreg_xprt_unregister/rpc_xprt_unregister.c
> > @@ -31,6 +31,10 @@
> >  #include <rpc/rpc.h>
> >  #include <sys/types.h>
> >  #include <sys/socket.h>
> > +#include <unistd.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +#include <string.h>
>=20
> >  //Standard define
> >  #define PROCNUM 1
> > @@ -49,6 +53,27 @@ int main(int argn, char *argc[])
> >  	int test_status =3D 1;	//Default test result set to FAILED
> >  	SVCXPRT *svcr =3D NULL;
> >  	int fd =3D 0;
> > +	struct sockaddr_in server_addr;
> > +
> > +	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
> > +	if (fd < 0) {
> > +		printf("socket creation failed");
> > +		return test_status;
> > +	}
> > +
> > +	memset(&server_addr, 0, sizeof(server_addr));
> > +	server_addr.sin_family =3D AF_INET;
> > +	server_addr.sin_port =3D htons(9001);
> > +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <=3D 0) {
> > +		printf("inet_pton failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
> > +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr))
> < 0) {
> > +		printf("connect failed");
> > +		close(fd);
> > +		return test_status;
> > +	}
>=20
> >  	//create a server
> >  	svcr =3D svcfd_create(fd, 1024, 1024);


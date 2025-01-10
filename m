Return-Path: <linux-nfs+bounces-9103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0EAA094FE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700F0188B1CA
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E00211A36;
	Fri, 10 Jan 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGeAshy+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD569211A2C
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522490; cv=none; b=EIPDb2bBgzy0bRH6xEGVBNHtl80TPuaXtswthCyj7xR2Lv0cr5DsqZUFnyauR9N/Y3h3WMWYctu76Rnc443NaJKxLL1m7PQlvnqULGSCCfObTKhKsKipipwci61gSYYbwGNmcrjw3MUK4rRH6v9jhKvpDYqozoyBwG81ZTEYwuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522490; c=relaxed/simple;
	bh=D5zgqVJeHgxBIe0E0a6YFyj1n49hDTywYmCsJ4gZ99M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bajxrevGWdAN8vCee7/KC9gxyeF33ueKB0HE9XbpxRJ8zFPeBVMO6JITByKZCICFd6yEqZYDmewGONAFxvUSgewptFmPcfeAfT8DTk7ReNA7K3QnNrUXxyzC96YOQ4Y81xW5CwtP7BsRM+6h2hMraFDhzdTtfDkMqN8iEmu+JgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGeAshy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9842C4AF0C;
	Fri, 10 Jan 2025 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736522490;
	bh=D5zgqVJeHgxBIe0E0a6YFyj1n49hDTywYmCsJ4gZ99M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rGeAshy+fEA/qVIgmGKR5j1yih3BlIvC7inSjvaWS0dVShnP38kR74uw8ArjbplUY
	 joUG2Vbj2zS2Kg465uOX68smdJ5jRR0SF1we1/eRboTGN6QW1pLzGA38+RjwkgBYQl
	 VPHdKjz0v9JqSe0ygMVJg/9ILqeV64n8wErOzVx0XjHxBguhuQ2ijVgxjqCM8IdAop
	 w0sX+PGX/R6eWlpykRDReLm3QswvwubGnA+i4NEfj/xRDaDiaxFEG3PIWTQiCZ3FiQ
	 Ltd8L3nbTFv4IgskbzDqv5j7hGByfmC2pUFkZ0VOYlsBp3Q1Rjdsv+OL26k/SiYzH6
	 Zhq3+L2LU7HDg==
Message-ID: <5b7b7284cb844b36ab89e77689f5baf5035f93e1.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
From: Jeff Layton <jlayton@kernel.org>
To: Tom Talpey <tom@talpey.com>, Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
	linux-nfs@vger.kernel.org
Date: Fri, 10 Jan 2025 10:21:28 -0500
In-Reply-To: <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
	 <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
	 <6c6bdf9b-858b-4a10-9317-f55aeda1ab80@talpey.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 10:05 -0500, Tom Talpey wrote:
> On 1/10/2025 8:46 AM, Jeff Layton wrote:
> > The legacy rpc.nfsd program would configure the nlm_grace_period to
> > match the NFSv4 grace period when starting the server. This adds simila=
r
> > functionality to the autostart subcommand using the new lockd netlink
> > configuration interfaces. In addition, if lockd's udp or tcp listener
> > ports are specified, also configure them before starting the server.
> >=20
> > A "nlm" subcommand is also added that will display the current lockd
> > config settings in the current net ns. In the future, we could add the
> > ability to set these values using the "nlm" subcommand, but for now I
> > didn't see a real use-case for that, so I left it out.
>=20
> It seems unnatural that the nlm_grace_period is tied to the netns.
>
> It seems to me it's more dependent on the network and its likely
> failure modes, the backend storage/filesystem, and perhaps the
> scale of clients performing possibly-conflicting locks. Oh, and
> also perhaps the minor version, since 4.1+ have the RECLAIM_COMPLETE
> termination event.
>=20
> Food for thought, perhaps.
>=20
> Tom.
>=20

Fair point. More food:

My guess is that nlm_grace_period handling is likely horribly broken in
multi-container scenarios anyway. If you have multiple nfs server
containers with different grace period settings, then they will all be
competing to set the global nlm_grace_period.

Most clients end up reclaiming quickly enough that we don't hit major
problems here, but it would be good to make this more "airtight".

> >=20
> > Link: https://issues.redhat.com/browse/RHEL-71698
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   configure.ac                  |   4 +
> >   utils/nfsdctl/lockd_netlink.h |  29 ++++++
> >   utils/nfsdctl/nfsdctl.8       |   6 ++
> >   utils/nfsdctl/nfsdctl.adoc    |   5 +
> >   utils/nfsdctl/nfsdctl.c       | 218 +++++++++++++++++++++++++++++++++=
++++++---
> >   5 files changed, 249 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/configure.ac b/configure.ac
> > index 561e894dc46f48997df4ba6dc3e7691876589fdb..1d865fbc1c7f79e3ac6152b=
c59995e99fe10a38e 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -268,6 +268,10 @@ AC_ARG_ENABLE(nfsdctl,
> >   				                   [[int foo =3D NFSD_CMD_POOL_MODE_GET;]])],
> >   				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
> >   					      ["Use system's linux/nfsd_netlink.h"])])
> > +		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h=
>]],
> > +				                   [[int foo =3D LOCKD_CMD_SERVER_GET;]])],
> > +				   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
> > +					      ["Use system's linux/lockd_netlink.h"])])
> >   	fi
> >  =20
> >   AC_ARG_ENABLE(nfsv4server,
> > diff --git a/utils/nfsdctl/lockd_netlink.h b/utils/nfsdctl/lockd_netlin=
k.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..21c65aec3bc6d1839961937=
081e6d16540332179
> > --- /dev/null
> > +++ b/utils/nfsdctl/lockd_netlink.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause) */
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/lockd.yaml */
> > +/* YNL-GEN uapi header */
> > +
> > +#ifndef _UAPI_LINUX_LOCKD_NETLINK_H
> > +#define _UAPI_LINUX_LOCKD_NETLINK_H
> > +
> > +#define LOCKD_FAMILY_NAME	"lockd"
> > +#define LOCKD_FAMILY_VERSION	1
> > +
> > +enum {
> > +	LOCKD_A_SERVER_GRACETIME =3D 1,
> > +	LOCKD_A_SERVER_TCP_PORT,
> > +	LOCKD_A_SERVER_UDP_PORT,
> > +
> > +	__LOCKD_A_SERVER_MAX,
> > +	LOCKD_A_SERVER_MAX =3D (__LOCKD_A_SERVER_MAX - 1)
> > +};
> > +
> > +enum {
> > +	LOCKD_CMD_SERVER_SET =3D 1,
> > +	LOCKD_CMD_SERVER_GET,
> > +
> > +	__LOCKD_CMD_MAX,
> > +	LOCKD_CMD_MAX =3D (__LOCKD_CMD_MAX - 1)
> > +};
> > +
> > +#endif /* _UAPI_LINUX_LOCKD_NETLINK_H */
> > diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> > index 39ae1855ae50e94da113981d5e8cf8ac14440c3a..d69922448eb17fb155f05dc=
4ddc9aefffbf966e4 100644
> > --- a/utils/nfsdctl/nfsdctl.8
> > +++ b/utils/nfsdctl/nfsdctl.8
> > @@ -127,6 +127,12 @@ colon separated form, and must be enclosed in squa=
re brackets.
> >   .if n .RE
> >   .RE
> >   .sp
> > +\fBnlm\fP
> > +.RS 4
> > +Get information about NLM (lockd) settings in the current net namespac=
e. This
> > +subcommand takes no arguments.
> > +.RE
> > +.sp
> >   \fBstatus\fP
> >   .RS 4
> >   Get information about RPCs currently executing in the server. This su=
bcommand
> > diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> > index 2114693042594297b7c5d8600ca16813a0f2356c..0207eff6118d2dcc5a794d2=
013c039d9beb11ddc 100644
> > --- a/utils/nfsdctl/nfsdctl.adoc
> > +++ b/utils/nfsdctl/nfsdctl.adoc
> > @@ -67,6 +67,11 @@ Each subcommand can also accept its own set of optio=
ns and arguments. The
> >     addresses must be in dotted-quad form. IPv6 addresses should be in =
standard
> >     colon separated form, and must be enclosed in square brackets.
> >  =20
> > +*nlm*::
> > +
> > +  Get information about NLM (lockd) settings in the current net namesp=
ace. This
> > +  subcommand takes no arguments.
> > +
> >   *status*::
> >  =20
> >     Get information about RPCs currently executing in the server. This =
subcommand
> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index 5c319a74273fd2bbe84003c1261043c4b2f1ff29..003daba5f30a403eb4168f6=
103e5a496d96968a4 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -35,6 +35,12 @@
> >   #include "nfsd_netlink.h"
> >   #endif
> >  =20
> > +#ifdef USE_SYSTEM_LOCKD_NETLINK_H
> > +#include <linux/lockd_netlink.h>
> > +#else
> > +#include "lockd_netlink.h"
> > +#endif
> > +
> >   #include "nfsdctl.h"
> >   #include "conffile.h"
> >   #include "xlog.h"
> > @@ -348,6 +354,28 @@ static void parse_pool_mode_get(struct genlmsghdr =
*gnlh)
> >   	}
> >   }
> >  =20
> > +static void parse_lockd_get(struct genlmsghdr *gnlh)
> > +{
> > +	struct nlattr *attr;
> > +	int rem;
> > +
> > +	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
> > +			  genlmsg_attrlen(gnlh, 0), rem) {
> > +		switch (nla_type(attr)) {
> > +		case LOCKD_A_SERVER_GRACETIME:
> > +			printf("gracetime: %u\n", nla_get_u32(attr));
> > +			break;
> > +		case LOCKD_A_SERVER_TCP_PORT:
> > +			printf("tcp_port: %hu\n", nla_get_u16(attr));
> > +			break;
> > +		case LOCKD_A_SERVER_UDP_PORT:
> > +			printf("udp_port: %hu\n", nla_get_u16(attr));
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> >   static int recv_handler(struct nl_msg *msg, void *arg)
> >   {
> >   	struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
> > @@ -368,6 +396,9 @@ static int recv_handler(struct nl_msg *msg, void *a=
rg)
> >   	case NFSD_CMD_POOL_MODE_GET:
> >   		parse_pool_mode_get(gnlh);
> >   		break;
> > +	case LOCKD_CMD_SERVER_GET:
> > +		parse_lockd_get(gnlh);
> > +		break;
> >   	default:
> >   		break;
> >   	}
> > @@ -398,12 +429,12 @@ static struct nl_sock *netlink_sock_alloc(void)
> >   	return sock;
> >   }
> >  =20
> > -static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
> > +static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const ch=
ar *family)
> >   {
> >   	struct nl_msg *msg;
> >   	int id;
> >  =20
> > -	id =3D genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
> > +	id =3D genl_ctrl_resolve(sock, family);
> >   	if (id < 0) {
> >   		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
> >   		return NULL;
> > @@ -447,7 +478,7 @@ static int status_func(struct nl_sock *sock, int ar=
gc, char ** argv)
> >   		}
> >   	}
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -495,7 +526,7 @@ static int threads_doit(struct nl_sock *sock, int c=
md, int grace, int lease,
> >   	struct nl_cb *cb;
> >   	int ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -607,7 +638,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock=
)
> >   	struct nl_cb *cb;
> >   	int ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -672,7 +703,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
> >   	struct nl_cb *cb;
> >   	int i, ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -825,7 +856,7 @@ static int fetch_current_listeners(struct nl_sock *=
sock)
> >   	struct nl_cb *cb;
> >   	int ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -1054,7 +1085,7 @@ static int set_listeners(struct nl_sock *sock)
> >   	struct nl_cb *cb;
> >   	int i, ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -1170,7 +1201,7 @@ static int pool_mode_doit(struct nl_sock *sock, i=
nt cmd, const char *pool_mode)
> >   	struct nl_cb *cb;
> >   	int ret;
> >  =20
> > -	msg =3D netlink_msg_alloc(sock);
> > +	msg =3D netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
> >   	if (!msg)
> >   		return 1;
> >  =20
> > @@ -1249,6 +1280,131 @@ static int pool_mode_func(struct nl_sock *sock,=
 int argc, char **argv)
> >   	return pool_mode_doit(sock, cmd, pool_mode);
> >   }
> >  =20
> > +static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace,=
 int tcpport, int udpport)
> > +{
> > +	struct genlmsghdr *ghdr;
> > +	struct nlmsghdr *nlh;
> > +	struct nl_msg *msg;
> > +	struct nl_cb *cb;
> > +	int ret;
> > +
> > +	if (cmd =3D=3D LOCKD_CMD_SERVER_SET) {
> > +		/* Do nothing if there is nothing to set */
> > +		if (!grace && !tcpport && !udpport)
> > +			return 0;
> > +	}
> > +
> > +	msg =3D netlink_msg_alloc(sock, LOCKD_FAMILY_NAME);
> > +	if (!msg)
> > +		return 1;
> > +
> > +	nlh =3D nlmsg_hdr(msg);
> > +	if (cmd =3D=3D LOCKD_CMD_SERVER_SET) {
> > +		if (grace)
> > +			nla_put_u32(msg, LOCKD_A_SERVER_GRACETIME, grace);
> > +		if (tcpport)
> > +			nla_put_u16(msg, LOCKD_A_SERVER_TCP_PORT, tcpport);
> > +		if (udpport)
> > +			nla_put_u16(msg, LOCKD_A_SERVER_UDP_PORT, udpport);
> > +	}
> > +
> > +	ghdr =3D nlmsg_data(nlh);
> > +	ghdr->cmd =3D cmd;
> > +
> > +	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> > +	if (!cb) {
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
> > +		ret =3D 1;
> > +		goto out;
> > +	}
> > +
> > +	ret =3D nl_send_auto(sock, msg);
> > +	if (ret < 0) {
> > +		xlog(L_ERROR, "send failed (%d)!\n", ret);
> > +		goto out_cb;
> > +	}
> > +
> > +	ret =3D 1;
> > +	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
> > +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
> > +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
> > +	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
> > +
> > +	while (ret > 0)
> > +		nl_recvmsgs(sock, cb);
> > +	if (ret < 0) {
> > +		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
> > +		ret =3D 1;
> > +	}
> > +out_cb:
> > +	nl_cb_put(cb);
> > +out:
> > +	nlmsg_free(msg);
> > +	return ret;
> > +}
> > +
> > +static int get_service(const char *svc)
> > +{
> > +	struct addrinfo *res, hints =3D { .ai_flags =3D AI_PASSIVE };
> > +	int ret, port;
> > +
> > +	if (!svc)
> > +		return 0;
> > +
> > +	ret =3D getaddrinfo(NULL, svc, &hints, &res);
> > +	if (ret) {
> > +		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
> > +			svc, gai_strerror(ret));
> > +		return -1;
> > +	}
> > +
> > +	switch (res->ai_family) {
> > +	case AF_INET:
> > +		{
> > +			struct sockaddr_in *sin =3D (struct sockaddr_in *)res->ai_addr;
> > +
> > +			port =3D ntohs(sin->sin_port);
> > +		}
> > +		break;
> > +	case AF_INET6:
> > +		{
> > +			struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)res->ai_addr;
> > +
> > +			port =3D ntohs(sin6->sin6_port);
> > +		}
> > +		break;
> > +	default:
> > +		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
> > +		port =3D -1;
> > +	}
> > +	freeaddrinfo(res);
> > +	return port;
> > +}
> > +
> > +static int lockd_configure(struct nl_sock *sock, int grace)
> > +{
> > +	char *tcp_svc, *udp_svc;
> > +	int tcpport =3D 0, udpport =3D 0;
> > +	int ret;
> > +
> > +	tcp_svc =3D conf_get_str("lockd", "port");
> > +	if (tcp_svc) {
> > +		tcpport =3D get_service(tcp_svc);
> > +		if (tcpport < 0)
> > +			return 1;
> > +	}
> > +
> > +	udp_svc =3D conf_get_str("lockd", "udp-port");
> > +	if (udp_svc) {
> > +		udpport =3D get_service(udp_svc);
> > +		if (udpport < 0)
> > +			return 1;
> > +	}
> > +
> > +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, =
udpport);
> > +}
> > +
> > +
> >   #define MAX_LISTENER_LEN (64 * 2 + 16)
> >  =20
> >   static void
> > @@ -1355,6 +1511,13 @@ static int autostart_func(struct nl_sock *sock, =
int argc, char ** argv)
> >  =20
> >   	read_nfsd_conf();
> >  =20
> > +	grace =3D conf_get_num("nfsd", "grace-time", 0);
> > +	ret =3D lockd_configure(sock, grace);
> > +	if (ret) {
> > +		xlog(L_ERROR, "lockd configuration failure");
> > +		return ret;
> > +	}
> > +
> >   	pool_mode =3D conf_get_str("nfsd", "pool-mode");
> >   	if (pool_mode) {
> >   		ret =3D pool_mode_doit(sock, NFSD_CMD_POOL_MODE_SET, pool_mode);
> > @@ -1370,15 +1533,12 @@ static int autostart_func(struct nl_sock *sock,=
 int argc, char ** argv)
> >   	if (ret)
> >   		return ret;
> >  =20
> > +	xlog(D_GENERAL, "configuring listeners");
> >   	configure_listeners();
> >   	ret =3D set_listeners(sock);
> >   	if (ret)
> >   		return ret;
> >  =20
> > -	grace =3D conf_get_num("nfsd", "grace-time", 0);
> > -	lease =3D conf_get_num("nfsd", "lease-time", 0);
> > -	scope =3D conf_get_str("nfsd", "scope");
> > -
> >   	thread_str =3D conf_get_list("nfsd", "threads");
> >   	pools =3D thread_str ? thread_str->cnt : 1;
> >  =20
> > @@ -1402,6 +1562,9 @@ static int autostart_func(struct nl_sock *sock, i=
nt argc, char ** argv)
> >   		threads[0] =3D DEFAULT_AUTOSTART_THREADS;
> >   	}
> >  =20
> > +	lease =3D conf_get_num("nfsd", "lease-time", 0);
> > +	scope =3D conf_get_str("nfsd", "scope");
> > +
> >   	ret =3D threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools=
,
> >   			   threads, scope);
> >   out:
> > @@ -1409,6 +1572,30 @@ out:
> >   	return ret;
> >   }
> >  =20
> > +static void nlm_usage(void)
> > +{
> > +	printf("Usage: %s nlm\n", taskname);
> > +	printf("    Get the current settings for the NLM (lockd) server.\n");
> > +}
> > +
> > +static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
> > +{
> > +	int *threads, grace, lease, idx, ret, opt, pools;
> > +	struct conf_list *thread_str;
> > +	struct conf_list_node *n;
> > +	char *scope, *pool_mode;
> > +
> > +	optind =3D 1;
> > +	while ((opt =3D getopt_long(argc, argv, "h", help_only_options, NULL)=
) !=3D -1) {
> > +		switch (opt) {
> > +		case 'h':
> > +			nlm_usage();
> > +			return 0;
> > +		}
> > +	}
> > +	return lockd_config_doit(sock, LOCKD_CMD_SERVER_GET, 0, 0, 0);
> > +}
> > +
> >   enum nfsdctl_commands {
> >   	NFSDCTL_STATUS,
> >   	NFSDCTL_THREADS,
> > @@ -1416,6 +1603,7 @@ enum nfsdctl_commands {
> >   	NFSDCTL_LISTENER,
> >   	NFSDCTL_AUTOSTART,
> >   	NFSDCTL_POOL_MODE,
> > +	NFSDCTL_NLM,
> >   };
> >  =20
> >   static int parse_command(char *str)
> > @@ -1432,6 +1620,8 @@ static int parse_command(char *str)
> >   		return NFSDCTL_AUTOSTART;
> >   	if (!strcmp(str, "pool-mode"))
> >   		return NFSDCTL_POOL_MODE;
> > +	if (!strcmp(str, "nlm"))
> > +		return NFSDCTL_NLM;
> >   	return -1;
> >   }
> >  =20
> > @@ -1444,6 +1634,7 @@ static nfsdctl_func func[] =3D {
> >   	[NFSDCTL_LISTENER] =3D listener_func,
> >   	[NFSDCTL_AUTOSTART] =3D autostart_func,
> >   	[NFSDCTL_POOL_MODE] =3D pool_mode_func,
> > +	[NFSDCTL_NLM] =3D nlm_func,
> >   };
> >  =20
> >   static void usage(void)
> > @@ -1460,6 +1651,7 @@ static void usage(void)
> >   	printf("    listener             get/set listener info\n");
> >   	printf("    version              get/set supported NFS versions\n");
> >   	printf("    threads              get/set nfsd thread settings\n");
> > +	printf("    nlm                  get current nlm settings\n");
> >   	printf("    status               get current RPC processing info\n")=
;
> >   	printf("    autostart            start server with settings from /et=
c/nfs.conf\n");
> >   }
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


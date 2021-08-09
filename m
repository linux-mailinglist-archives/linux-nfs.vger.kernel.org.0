Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8B3E4744
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhHIOM6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 10:12:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234788AbhHIOM5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 10:12:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179EBVDj009744;
        Mon, 9 Aug 2021 14:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b80fF9HIQmcwjqn0rNYhsVgjaN6RWweSTMgVL3f1V0E=;
 b=KkcLfSSzeAP4abOq7UocZk+/GJj2A2qJnz6ASDfbQU174mNp+ngtuBjInS2iMpeH3jMo
 OBzfmCWMFI/44Tvin3qHwy9IUNyP1zjRTc+6+0xOjws695Y1nBw3p8qZiHBtJNh8F9ef
 yEoQ6Xb9F2Xjw7G+fgKukaC+H1ladOy2xTa286A7xWNy7J7hZjyWskmujJ+UYxVI0PhU
 CS/V7iBqM1rO0NrMAnCPEBMF16ZqvB9X4ObhSLqxw3b1kGY4OvlHK++2qOjgkQLyWSCT
 Vdn+wqi8KBcdAM+EqPhWQE+9tgg++lEL0kAoAADgMFErvA2nU9J9NAWmIzE17WYZnV7M rQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=b80fF9HIQmcwjqn0rNYhsVgjaN6RWweSTMgVL3f1V0E=;
 b=x2ISOsb2Qlls0p9nbPnQNxTOJ3mW0V0V2dMylZ2jsS4q9iKGLqyQ0oTbItNeJVV6h8uo
 sbpyThfUZ3Kn/Q557OrRfcmo/xbrLqlLx1pwZhHK7peyrZuxVuVqEOyfbGoVO+kgKBlo
 0R/iZDbvY1qD4J2n7iolESOE0b0fymvf95AwpAOzEoYs7YosfDVS/NMr3+VEHWgtKE26
 EaJndKyVq1Bj6PCbPHHLgB+RBOQ6PPdJI5Md7d1inVd9LhC51Wc/QEouIRPHkR14QONH
 8zcCI72gUwEhZMos94q4o3tsnyPIEOhGZDHUn3lsyLjpr1pyeE/67y4iBMEVopcW2tUo Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aav18ha6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:12:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179EA43t021566;
        Mon, 9 Aug 2021 14:12:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3a9f9v412f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYpzZKbUpV4fqcWk5FY4fOllcYMDwscen2kYtGFEbJmZ8RJckgnqcEHm14az886lK7a/kKz+zBhX8Z+K+Rmq4kgyOaAhsCl1DmmZyj3PQy5vxCGHpcj9uS1kNcUnuBiE1e3/WNlEycjwQ/kwrXfgev00MsdFHTgMb11RvP5JWOuMpZoA3ecmqkEbe+4Hsb0Swtxc+ABaKsyx5G1Oqc0N5JQY0AcJ8pYYrHJWnlrJyvgFU86arFEP0QnkhtusSEiO1AaqpQor2PHz8ghlPDACUu5q/l6FgCGivXzaCdquLF6k1WQTVEQ+1kt7MddZWmCsieAlyVI1MlvvTujF/LSq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b80fF9HIQmcwjqn0rNYhsVgjaN6RWweSTMgVL3f1V0E=;
 b=YTtGBf8c/smTjf2QIp9xOrj+1B+KaNKXO7bY4m7o/59fnUyowqdojuEZ4UY+TCPpn626I86czs8QiAiURQA4CLnflOgPvISVN6rvWmpfuE1OicJqZ3QQ5s+0aJDSUOFun16tWkMqT9VMFCaXKWuX2JZYsb0yJeztoSvfBKl9HCNE7oV4a0Opov4kyOLiNZQjq/CtJfePSLYvs5UdIvVa4e2L/9+zQG81XiISKHS2AM7iQLaT5ySuLMR0P6Hz1L6+wJj7RoNWmaLIASbekqZcb4+scE7cH+ODvKHa67L5sU48MM9ifsNCxsSP8YzLy6hUJRO/X2oe63JQCtQqHdVMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b80fF9HIQmcwjqn0rNYhsVgjaN6RWweSTMgVL3f1V0E=;
 b=Tu3cbff2ChnXu1W1HAPfS3W/Sgn/xVARFujq6I31V9kkBKSXfx4BpF+JDG3w4afVY+v3gV3BOKa4Ts8otNfC3wsHG8qNNbUxUtiFas2MejpSM/UNxAicqwi0FGF22nfcBz1h3SDwBRAMLnJ2fLRjqqKdtrtsnY8/aKzsL+K5j8I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 14:12:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:12:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Libtirpc-devel] [PATCH 1/1] Fix DoS vulnerability  in libtirpc
Thread-Topic: [Libtirpc-devel] [PATCH 1/1] Fix DoS vulnerability  in libtirpc
Thread-Index: AQHXi63WJ1R0B5JYxE2BSyGx44nxrKtrOb2A
Date:   Mon, 9 Aug 2021 14:12:14 +0000
Message-ID: <D8E30E37-EF13-42D1-9F0A-DC2222944FFE@oracle.com>
References: <20210807170047.68720-1-dai.ngo@oracle.com>
In-Reply-To: <20210807170047.68720-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c12f1ca0-abee-4493-7b53-08d95b3fafff
x-ms-traffictypediagnostic: SJ0PR10MB5406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB5406D920088907832CA55A8E93F69@SJ0PR10MB5406.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvKdUm4fhNkq4gUnr3k+zZ3dVdLjxLIi517ZW7IPcS/qW+9aHKDMZ09bJxC4lFiVUxqnsnDda3IvuBLNStzbxGp+sk7vUCyBXtX1vaUTvzUEvgqfSfnBT0L8YBVhHmmjAlCZb++eT/7cW3tolv05Ge6NU/BWU+TPB+yNYdJvrpMCst/cGR0HaqaGeyXqGPXpmgAL1thtg6r8BQNZn1V8wRaQjVnIvdXdt+0fVFow9H5tz4tUGFM+yImFg11F9p7C+rLxWeOkbD7vtIpZ160UUKAB7JusqfA1cDai5FnwyCqKyMjbDuPMM9UGNfAa/acbJCgSQ3kREPN10m0xIRqqtV3FHjjVkRb4/BcMG8jQG4+idkHJIIJj3KpeamaI85tit9bgOJkeAmvAWh+NQ7zbTidqLPY8IhdeKU/Qzm4wYUqcmC+sA/Xp622IAEAcYwqyQH4K4AbKXwlDv3Lwmx13t1MUoUrBo+vJpBOYMjPTiJVWOYpU+xzh7UwsMBeR9I3EMl0G0gPyLdbs1yAwmBkTihUyxKbshvfDSoZnoGVGkKJcEawfre4yw2keJwAaFAHlPyX5okhsiu/SYVTMfT+NVWCodPXfQs9aSycqLWcImQmaHmmdUSAKnu01Pwmj8wyV4mI4Lvb4Acf5Akh3WOvXKK1LRi+cKfd0BtMtV7BlRTmZZPDB/Y76o+xb5JYUQ+TdJ1Jizg3H6WEtlOOthA3HNS16gg/Uo9s3oWhextplbyFAOeI3eOpClKug5Ec4nUNa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(91956017)(478600001)(76116006)(6636002)(2616005)(5660300002)(2906002)(66946007)(8936002)(38100700002)(38070700005)(122000001)(54906003)(37006003)(36756003)(316002)(8676002)(86362001)(66556008)(186003)(71200400001)(4326008)(26005)(6862004)(6486002)(33656002)(83380400001)(64756008)(6506007)(66476007)(53546011)(66446008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWpYoKgVu71ELq7Jk9twqltF4v6czesAGEa2ffwSpl7F8A1iLg2zq9etgnwm?=
 =?us-ascii?Q?f6938DYh3vfnyz3NcIzdi1nrnIBSoIZZsyUgJFmKRveZfTJvRGJYZDvFoFj+?=
 =?us-ascii?Q?7AjFZv5uKOd+VSdbeY0aSeyLRRFMbza7GypkhqE65jI+lGopoDFiRknwD8ON?=
 =?us-ascii?Q?NyaBnO3ujkdF2B0//VcB4RZh6KJk23kbltlf/uDlgMhrtO7p+DCdhyRM7Bhc?=
 =?us-ascii?Q?UqbBKcBNSGBc4s/HGMNeIaKpy959l8D4DxpFW5sR2bUpO9z4CfajVC1yOLKe?=
 =?us-ascii?Q?yEnsLh2fH6EIxgiAyJIrbi96I2SbEoxRY/qmovlToGonW+PHtEDadZn7x2YM?=
 =?us-ascii?Q?eIzIBTAB6/IOuayi/HM+kgNoXRbDjWJyKiFlYFcNnpq+RqCVvMktIFfEETU/?=
 =?us-ascii?Q?4423JL6RpHMt71H2itxbrR5gOFdnDiec4FGAWTpIDI4AtRQLNJ4vyRtdbi2t?=
 =?us-ascii?Q?mwVUezPc/kgoV2hIazSpiyGtkIKym2yFSX3i8G0uy1PNV+1yDB0QSYcsvkTM?=
 =?us-ascii?Q?gOYlNSEsIdFIyff7pYBfOaKLDuQ6w65k9tNAs0AW5YCdx2RTH2udnfgO04F6?=
 =?us-ascii?Q?laPGi/acolJSdqtJeZK4JVmt18hGW3r1cHjKQ34fwqmSFOlXvDFQ4L/uiSwo?=
 =?us-ascii?Q?TZqh/l/jsHGBS6i+7fWj7FXZTn26BPByQ9EjR5nnk9DCxuIEL+pIXXC71nBj?=
 =?us-ascii?Q?Uz4A9UuwWi7nr1mHVURJA6bnsSv5GuqwFT/rJfrPy1hQI4IQ/rgGeFQZE25B?=
 =?us-ascii?Q?Hp9igEocz4Y6fu8ct+0Of3Ig9Hgq1HHihI1KVGGgMSp1NuadD1vXVDvOE3uB?=
 =?us-ascii?Q?gurZ4tHZ4h/52IolNUvWV7FvozZQSTmdXhDXRM7HRM+XIat9ncANiyudpH65?=
 =?us-ascii?Q?jXiabiV67HGX5Fk+vqXtrjeYQ+R7m+XD4ZnNOTPbSdcEAp4DuQy3Z4ExRCjP?=
 =?us-ascii?Q?/e3m0g0QrzBbqCZC9zJ1PbjQKQA/BRlpwlm4A+V91VpWScrpm2dCkpBdsNCb?=
 =?us-ascii?Q?cta88ie2pcIUxo7jpznIbMjSJ8oMbYhJ409iaV5sMGzgHY/tgeogQ/TR2s2N?=
 =?us-ascii?Q?D/lIcNo5VOkPNqT6gfKGx+I7Bgu9UZ0o+cwn8G29OmF/LzpjLSWXCl6BBVZ0?=
 =?us-ascii?Q?0BKezEqhIn9C24AOKbjYL92weqb6bTTdqspOoiFNRPfrkn8BM1NQ3JGpA6vx?=
 =?us-ascii?Q?Oc7fnIQ6ZT6ScmZsC3hHmPdwvXNWNcsGR9IZU0/190uaPi9HVu8BhyelWFc/?=
 =?us-ascii?Q?/tXIiFQhwhUjJJBtBUchR6oDCr6BfOy54ySFt//9Ls2RWvpK+aVJFHpY0k68?=
 =?us-ascii?Q?5ImuD0oJoMmmC7Q4nXTk8JrnM+pFLaU0DHgSepqfhXLUGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC3F966C859B374E9092A3F65B3998CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12f1ca0-abee-4493-7b53-08d95b3fafff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:12:14.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8G+tSTwZNySE9O0DUG5Bni4p4T1cPWUnTnlOupBUMh8CZIOnwf/tTlzkbT37xXLmlRhtjAoihkG1JYMnbv9f/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090106
X-Proofpoint-ORIG-GUID: WntZQSlh7wTJQXZt5KzN_Ew9mqlRnORl
X-Proofpoint-GUID: WntZQSlh7wTJQXZt5KzN_Ew9mqlRnORl
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 7, 2021, at 1:00 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently svc_run does not handle poll time and rendezvous_request
> does not handle EMFILE error returned from accept(2 as it used to.
> These two missing functionality were removed by commit b2c9430f46c4.
>=20
> The effect of not handling poll timeout allows idle TCP conections
> to remain ESTABLISHED indefinitely. When the number of connections
> reaches the limit of the open file descriptors (ulimit -n) then
> accept(2) fails with EMFILE. Since there is no handling of EMFILE
> error this causes svc_run() to get in a tight loop calling accept(2).
> This resulting in the RPC service of svc_run is being down, it's
> no longer able to service any requests.
>=20
> The below script, td.sh, with nc (nmap-ncat-7.80-3) can be used
> to take down the RPC service:
>=20
> if [ $# -ne 3 ]; then
>        echo "$0: server dst_port conn_cnt"
>        exit
> fi
> server=3D$1
> dport=3D$2
> conn_cnt=3D$3
> echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"
>=20
> pcnt=3D0
> while [ $pcnt -lt $conn_cnt ]
> do
>        nc -v --recv-only $server $dport &
>        pcnt=3D`expr $pcnt + 1`
> done
>=20
> Fix by restoring code in svc_run to cleanup idle conncetions when
> poll(2) returns 0 (timeout) and in rendezvous_request to handle
> EMFILE error returned from accept(2).
>=20
> Fixes: b2c9430f46c4 Use poll() instead of select() in svc_run()
> Signed-off-by: dai.ngo@oracle.com
> ---
> src/libtirpc.map |  2 +-
> src/rpc_com.h    |  2 ++
> src/svc.c        |  2 +-
> src/svc_run.c    |  2 ++
> src/svc_vc.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/libtirpc.map b/src/libtirpc.map
> index 21d60651ff57..b754110faadb 100644
> --- a/src/libtirpc.map
> +++ b/src/libtirpc.map
> @@ -331,5 +331,5 @@ TIRPC_PRIVATE {
>   global:
>     __libc_clntudp_bufcreate;
>   # private, but used by rpcbind:
> -    __svc_clean_idle; svc_auth_none; libtirpc_set_debug;
> +    __svc_destroy_idle; __svc_clean_idle; svc_auth_none; libtirpc_set_de=
bug;

As I stated yesterday, as a reviewer I agree with everything
in this patch except for the addition of __svc_destroy_idle
to the library's private API list.

IMO the private __svc_clean_idle() API was a mistake we
shouldn't make again. (That might be why Thorsten removed
it years ago).

Thanks, Dai, for your work nailing this down!


> };
> diff --git a/src/rpc_com.h b/src/rpc_com.h
> index 76badefcfe90..ede6ec8b1d4e 100644
> --- a/src/rpc_com.h
> +++ b/src/rpc_com.h
> @@ -55,6 +55,7 @@ struct netbuf *__rpcb_findaddr_timed(rpcprog_t, rpcvers=
_t,
> bool_t __rpc_control(int,void *);
>=20
> bool_t __svc_clean_idle(fd_set *, int, bool_t);
> +void __svc_destroy_idle(int, bool_t);
> bool_t __xdrrec_setnonblock(XDR *, int);
> bool_t __xdrrec_getrec(XDR *, enum xprt_stat *, bool_t);
> void __xprt_unregister_unlocked(SVCXPRT *);
> @@ -62,6 +63,7 @@ void __xprt_set_raddr(SVCXPRT *, const struct sockaddr_=
storage *);
>=20
>=20
> extern int __svc_maxrec;
> +extern SVCXPRT **__svc_xports;
>=20
> #ifdef __cplusplus
> }
> diff --git a/src/svc.c b/src/svc.c
> index 6db164bbd76b..aa0c92591914 100644
> --- a/src/svc.c
> +++ b/src/svc.c
> @@ -57,7 +57,7 @@
>=20
> #define max(a, b) (a > b ? a : b)
>=20
> -static SVCXPRT **__svc_xports;
> +SVCXPRT **__svc_xports;
> int __svc_maxrec;
>=20
> /*
> diff --git a/src/svc_run.c b/src/svc_run.c
> index f40314b9948e..4eba36174524 100644
> --- a/src/svc_run.c
> +++ b/src/svc_run.c
> @@ -44,6 +44,7 @@
> #include "rpc_com.h"
> #include <sys/select.h>
>=20
> +
> void
> svc_run()
> {
> @@ -86,6 +87,7 @@ svc_run()
>           warn ("svc_run: - poll failed");
>           break;
>         case 0:
> +          __svc_destroy_idle(30, FALSE);
>           continue;
>         default:
>           svc_getreq_poll (my_pollfd, i);
> diff --git a/src/svc_vc.c b/src/svc_vc.c
> index f1d9f001fcdc..4880ab5dbc26 100644
> --- a/src/svc_vc.c
> +++ b/src/svc_vc.c
> @@ -58,6 +58,7 @@
>=20
> #include <rpc/rpc.h>
>=20
> +#include "debug.h"
> #include "rpc_com.h"
>=20
> #include <getpeereid.h>
> @@ -337,6 +338,10 @@ again:
> 	if (sock < 0) {
> 		if (errno =3D=3D EINTR)
> 			goto again;
> +		if (errno =3D=3D EMFILE || errno =3D=3D ENFILE) {
> +			/* remove least active fd */
> +			__svc_destroy_idle(0, FALSE);
> +		}
> 		return (FALSE);
> 	}
> 	/*
> @@ -820,3 +825,46 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cl=
eanblock)
> {
> 	return FALSE;
> }
> +
> +void
> +__svc_destroy_idle(int timeout, bool_t cleanblock)
> +{
> +	int i;
> +	SVCXPRT *xprt, *least_active;
> +	struct timeval tv, tdiff, tmax;
> +	struct cf_conn *cd;
> +
> +	gettimeofday(&tv, NULL);
> +	tmax.tv_sec =3D tmax.tv_usec =3D 0;
> +	least_active =3D NULL;
> +	rwlock_wrlock(&svc_fd_lock);
> +
> +	for (i =3D 0; i <=3D svc_max_pollfd; i++) {
> +		if (svc_pollfd[i].fd =3D=3D -1)
> +			continue;
> +		xprt =3D __svc_xports[i];
> +		if (xprt =3D=3D NULL || xprt->xp_ops =3D=3D NULL ||
> +			xprt->xp_ops->xp_recv !=3D svc_vc_recv)
> +			continue;
> +		cd =3D (struct cf_conn *)xprt->xp_p1;
> +		if (!cleanblock && !cd->nonblock)
> +			continue;
> +		if (timeout =3D=3D 0) {
> +			timersub(&tv, &cd->last_recv_time, &tdiff);
> +			if (timercmp(&tdiff, &tmax, >)) {
> +				tmax =3D tdiff;
> +				least_active =3D xprt;
> +			}
> +			continue;
> +		}
> +		if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
> +			__xprt_unregister_unlocked(xprt);
> +			__svc_vc_dodestroy(xprt);
> +		}
> +	}
> +	if (timeout =3D=3D 0 && least_active !=3D NULL) {
> +		__xprt_unregister_unlocked(least_active);
> +		__svc_vc_dodestroy(least_active);
> +	}
> +	rwlock_unlock(&svc_fd_lock);
> +}
> --=20
> 2.26.2

--
Chuck Lever




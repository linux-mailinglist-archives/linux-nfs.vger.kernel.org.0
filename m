Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5814637AB3B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKQAN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 12:00:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57570 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKQAM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 12:00:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BFeHGT163006;
        Tue, 11 May 2021 15:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/dg+UdjROsACkyXpBO/0Lb/cSX6YsEl5o/OwrdaaICg=;
 b=PIr0LZW70OaP0a6hH3UJtXMbIW30PmztBfcl1o1EK1/25Upr6FG9MkPzSPkw7MIxTHj/
 Z9QTDnHhlVywqcztquXRAFmsrynplbyPg37mMobp5f4R3EQyeUp2iNudYAvlSoSCGba5
 d6am6blvrI4UMLv/bansHMWiYhvZNv4vhKXjF709whc1IxcyfhdQinBspXbOVptynYV8
 5OZO0n4jbZ2gtC3ceKKw5NxupjcjgpUqrGPZ8+kVClAW9ovAYHnQJRqTi28Tg4ip+hyX
 Mk3O8oH5jOiSsMaXoFa+gj6gkT+wPIx3D5v+8AcMqpaC3mpp1AwUijgGxa7Y7jMpgM/N Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5bfd23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:59:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BFfdss101313;
        Tue, 11 May 2021 15:59:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 38dfrxfnfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhq+i8HtVYUh7PignLfaFAoWGXr/KeTBpEzsLIYRG4N55vumAO4F9yxzPDee8RCpK2viT2UpwHhVrYFNX5ylLoGIfrZll4as4wc8O+slhdz4hkbRJ9QrplaifX+TXvJsubGTd1q6AD4MYbn3TawJed4erepNcXPRY039cZUg8waFmQWB/EnOgAHpM3DVYh4Lz8L1/95TkmYFAVL3zXXHuRvL0XPmOCahtmXyGzbzP1z0YnPK1j66iz3zimAL1mnO7cxGgiP2p9XSXPZBD3LhrDmtjRz5ugEPQOsFGOroQkiEbFCkmT7TGLqFpGOX8vRtfdtZBwPk0vusHmDp3W784Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dg+UdjROsACkyXpBO/0Lb/cSX6YsEl5o/OwrdaaICg=;
 b=C8PJaKKODinRquGXrcZ4hfD63T110d5oMoSwQM5xIUOqyIzKpOZHazH1nOdHPdxZNqhKEN6PZgpBKP+9JeA0G3bwnJOxmxtuqzjO33NfHmnUgPYYBcphALTh4Wpck8am3p/6bFK34UByP6BOEi8fr+YA1I5vF2NIAYuTx/NTYk7ZlS9wBzW01Jkz4XRiuK0GEKupthn+SPlr+WmimtiKPg+ggjORE+Sq0CiuV5W5U6Uv/gu3lMYMFDKR1hN4/biTOBbSLjKn6hCMvUMhy5CItbusyZL0SvOYa+Sd/WGl4CmCBnReXDo1JqkANFHEQIbwTiNgOv1mwNIwFlrwSAoshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dg+UdjROsACkyXpBO/0Lb/cSX6YsEl5o/OwrdaaICg=;
 b=bSzxFDwouR/dn2uCZIBz6+/nLjSNakbQSIdMFIQubVIvOYeUwgK4nOJ7qMQXVtqkSVYtpWQSnm/0EK+rL5xIazJqZBDcPtuCW2UuGHccg9mik2OHOxqoOX2XePiOdnekyxC56FZu36R4j2pKFd6F/Wquuk3UTlNy02x7zd4y3m8=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR1001MB2079.namprd10.prod.outlook.com (2603:10b6:301:2b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 15:59:00 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:59:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>
Subject: Re: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Topic: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Index: AQHXRbSucZYUv8RjjEGtdKxv5mPBy6recbEA
Date:   Tue, 11 May 2021 15:59:00 +0000
Message-ID: <7922E4B6-BB7F-4D9E-B85D-D1A97835AF3F@oracle.com>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
In-Reply-To: <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c924730a-7973-4d48-050e-08d91495b100
x-ms-traffictypediagnostic: MWHPR1001MB2079:
x-microsoft-antispam-prvs: <MWHPR1001MB2079E3F4ACF3A85A8194E0A393539@MWHPR1001MB2079.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3o3pCnqQldV1NHLNQ/+Fm9J/Ddgc96XOwClLUv7RCnCAWG1gk5M5N2Un3OuZMjMmnzz/aRwlh+PT8eQ23MKzcrQ4X9qblXbRwx3FN1eWWek6hhw7eMlm3RTc2zWZuKWlZQPVhh4gXtQd5ZGd6TaC/EphuV9UosrWBaZJxiWE8FRRUVq6kDtUvUTIk92NAucvKVtjX/JcsyPBsyhTQzG4dQJA8SGSMI8/Bt8hs2PXSzmdhFoDuIdKAFpXZCy6EDp646/EvCzYay8mev6v7gXOaberq3d18aVw8G7BHVdtQqc8xdrQklAhGJyTYv1Y1XlVPqRk20fB9xmmweXB0QyXxJWZVOCAWFTqLjaV/p3FYTKp8NDeNFIGgUC6E82Q++MJ3zRVmRkLNGKKLZV2aSliEWjcxVGF/0+Ky2ib4JAZwI8kuvYlsAvl8br9DtBHOre3DXkCQICFcIDRbhyzTMMs3+BEINjE1z6AR5pI9VtXUMs/6VsEcGwkkteGFVK1/qbrOXdLfaKkpgrGFNJyJlhyAneIfwMmsnwYIbCKHgtFDu2q7UcG3y2o/f/aRVtGghWvL9xh7bEG4g5tVYXFlnxx6x2SU4GfsGJ17MrUjdK9auuYACn7n0VYNVIzVak2PB7qs3WCdmbynwQm8F6zKDQ0MTezI76FuiR9s980B6JtyU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(53546011)(76116006)(91956017)(71200400001)(8676002)(36756003)(86362001)(186003)(2906002)(6506007)(5660300002)(83380400001)(33656002)(26005)(6486002)(6512007)(54906003)(2616005)(478600001)(316002)(66476007)(64756008)(66556008)(4326008)(8936002)(38100700002)(66946007)(122000001)(6916009)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ayU4j3sjTgIPVMoNDkYDULKbjMrk+x2IflF34u26aSMiWKs+t7asxsOy0QUG?=
 =?us-ascii?Q?qTjmHgfI82bBws2Q7Zdq/hw36RIlXvuAnc/NP5qWSkphJdba31ubh6QZXUbD?=
 =?us-ascii?Q?c+NUkW/BJrFg3/SPa0faWUyOfHb/fAfO7RNy9J4d6VYIMkww3LjXN1OzWXIK?=
 =?us-ascii?Q?RfU4c9GcWKcEb1vDU0c0Ib834x7Ignu1tWDmqGDuSGYiin1ZG5C0ml1qfb/s?=
 =?us-ascii?Q?bVVGofQQt14os9oHapjNXnyo6f5Guf6PW3ZRAiaFWn3AIv6xuTeKCvB0oaMp?=
 =?us-ascii?Q?0yJT/DcpMfVgoFCEJQhC9O58CN6LNqqtpcoXXuXRyyLsuD2C3CrgKAaq8OHt?=
 =?us-ascii?Q?AHGX1Ur0C7j+vYFCHlNfF4sHv3ATuMWQTgoYiFpDE+7UUe2YxTA+s4Ak/67e?=
 =?us-ascii?Q?qDO+vM36zDfPQJkbAJd3INKr7wzCd1A82k6KDp1AAppZHkWNAdl6zQnsLzO9?=
 =?us-ascii?Q?5I9n9T+isjloZulupM2Vrp69jJKNiA2GKsZtPtMkYdkENbzWDnxd15WxXc5b?=
 =?us-ascii?Q?BLkxIMHMt7RJU9scx/P86en7St/pZslZML/Pw1pRfalIGpyCFPTi9nD0Ahy4?=
 =?us-ascii?Q?bHRTZiqJQqCQfKaQJQqjL2XNnncFoZ11J7MYHhqhkQjOADG7voEBoJext5mL?=
 =?us-ascii?Q?WL7cYbDrjY1kiWhab347dlYVC3GhNQJKM7q9FhkTeKFV+2UuoQlGJL/hZq/B?=
 =?us-ascii?Q?tG4mSkarJAixLreXHRzVTHbM97TenIPXfPhTa6XuO90buzXpAxQlTTxAMlgw?=
 =?us-ascii?Q?gmD8k1FDaEgJtS3m1rFjrWTJM1ydS11S2CG0PAtsNHSoYouCZl6RElRnlTQI?=
 =?us-ascii?Q?B0NDwfGHbW2ZzUR2zNyizh0DfCnRGLD7P7lxi1ovuRrtTxsQMjXZYZrZTCm5?=
 =?us-ascii?Q?qGmgQsy5qPr1zEbG7nSOa7A8C+A6vhbtNBl/drpuDVvRyiwyuOMHa8zmFvha?=
 =?us-ascii?Q?Rk4b5i9hX6v5gL9piQgeM/oSkmhIDsX0qHzIRqUkS+YuWkayd5vAIoBN6Hcm?=
 =?us-ascii?Q?5c+Gx5KppP8AshDdjNrVeESrLyI9+1bHs6np0xTl4qCpoAH6o4fTTGOhOfJe?=
 =?us-ascii?Q?aVfnhU1OXM4/WvTFsSLllWp1dFZk/FWoaIibacWGqav9m8YwdRuoSfTasFtw?=
 =?us-ascii?Q?kDChw19X1FpDrEKMjl4YIn3hwUqJQu8/xOS5PwVxYWOXyji9VqDIj/ElZJhN?=
 =?us-ascii?Q?EpnrJHPQM3Jox/vsTNmWEeHbTl/HiYWHdwTNGlbOuOvcERakQOyRSbn4uMPU?=
 =?us-ascii?Q?zM4sW6/iRJ/BgyOUq7EE4o2BxKsUGySIpDW8qlY29YejjPyAtmyEtsWUtXXd?=
 =?us-ascii?Q?nIcWH3fOCIC97GAGrx6UCeYUieB281+G0tcXbibq9gVYtw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F688D0BE113B141AE115F35C7AA399B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c924730a-7973-4d48-050e-08d91495b100
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 15:59:00.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF4ZUhMVjBTIn0SC1l+DhDbeF5x3dmhySWcaQVy/FtzqxpsQqL0eDC5iz4+ciEJ0cDa91B7dHcIHI5daefnFUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110113
X-Proofpoint-GUID: cbtUKWYiYMRMXb_nznaVFOUfKRSbSPuG
X-Proofpoint-ORIG-GUID: cbtUKWYiYMRMXb_nznaVFOUfKRSbSPuG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110113
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As Dave reported yesterday, this patch is unfinished and is probably
junk. But any thoughts on how the tracepoints should be organized
in this code would help.

So I was thinking we probably want a tracepoint to fire for each
case that is handled in this code (and in nfsd4_exchangeid).
However, this comment in nfsd4_setclientid:

   /* Cases below refer to rfc 3530 section 14.2.33: */

Is confusing.

- RFC 3530 is superceded by RFC 7530, and the section numbers have changed.

- The cases in this section in both RFCs aren't numbered, they are
bullet points.


> On May 10, 2021, at 11:53 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> We are especially interested in capturing clientID conflicts.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/nfs4state.c |    9 +++++++--
> fs/nfsd/trace.h     |   37 +++++++++++++++++++++++++++++++++++++
> 2 files changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a61601fe422a..528cabffa1e9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3180,6 +3180,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> 			}
> 			/* case 6 */
> 			exid->flags |=3D EXCHGID4_FLAG_CONFIRMED_R;
> +			trace_nfsd_clid_existing(conf);
> 			goto out_copy;
> 		}
> 		if (!creds_match) { /* case 3 */
> @@ -3188,15 +3189,18 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 				trace_nfsd_clid_cred_mismatch(conf, rqstp);
> 				goto out;
> 			}
> +			trace_nfsd_clid_new(new);
> 			goto out_new;
> 		}
> 		if (verfs_match) { /* case 2 */
> 			conf->cl_exchange_flags |=3D EXCHGID4_FLAG_CONFIRMED_R;
> +			trace_nfsd_clid_existing(conf);
> 			goto out_copy;
> 		}
> 		/* case 5, client reboot */
> 		trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
> 		conf =3D NULL;
> +		trace_nfsd_clid_new(new);
> 		goto out_new;
> 	}
>=20
> @@ -3996,10 +4000,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 		if (same_verf(&conf->cl_verifier, &clverifier)) {
> 			copy_clid(new, conf);
> 			gen_confirm(new, nn);
> +			trace_nfsd_clid_existing(new);
> 		} else
> 			trace_nfsd_clid_verf_mismatch(conf, rqstp,
> 						      &clverifier);
> -	}
> +	} else
> +		trace_nfsd_clid_new(new);
> 	new->cl_minorversion =3D 0;
> 	gen_callback(new, setclid, rqstp);
> 	add_to_unconfirmed(new);
> @@ -4017,7 +4023,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> 	return status;
> }
>=20
> -
> __be32
> nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 			struct nfsd4_compound_state *cstate,
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 523045c37749..6ddff13e3181 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -626,6 +626,43 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
> 	)
> );
>=20
> +DECLARE_EVENT_CLASS(nfsd_clid_class,
> +	TP_PROTO(const struct nfs4_client *clp),
> +	TP_ARGS(clp),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +		__field(unsigned long, flavor)
> +		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
> +		__field(unsigned int, namelen)
> +		__dynamic_array(unsigned char, name, clp->cl_name.len)
> +	),
> +	TP_fast_assign(
> +		memcpy(__entry->addr, &clp->cl_addr,
> +			sizeof(struct sockaddr_in6));
> +		__entry->flavor =3D clp->cl_cred.cr_flavor;
> +		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
> +		       NFS4_VERIFIER_SIZE);
> +		__entry->namelen =3D clp->cl_name.len;
> +		memcpy(__get_dynamic_array(name), clp->cl_name.data,
> +			clp->cl_name.len);
> +	),
> +	TP_printk("addr=3D%pISpc name=3D'%.*s' verifier=3D0x%s flavor=3D%s clie=
nt=3D%08x:%08x\n",
> +		__entry->addr, __entry->namelen, __get_str(name),
> +		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
> +		show_nfsd_authflavor(__entry->flavor),
> +		__entry->cl_boot, __entry->cl_id)
> +);
> +
> +#define DEFINE_CLID_EVENT(name) \
> +DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
> +	TP_PROTO(const struct nfs4_client *clp), \
> +	TP_ARGS(clp))
> +
> +DEFINE_CLID_EVENT(new);
> +DEFINE_CLID_EVENT(existing);
> +
> /*
>  * from fs/nfsd/filecache.h
>  */
>=20
>=20

--
Chuck Lever




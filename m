Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583FC3DBF42
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhG3Twl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 15:52:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64436 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhG3Twl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jul 2021 15:52:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UJpZrl030605;
        Fri, 30 Jul 2021 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=35fkW0H+8F5do+Nt3s5kznxvYBEy4Ui104J8H9GGEqA=;
 b=TOwx1s5k9CnnoahQJ+L9qG3kmiNJ6mbg1vLbi/TFHaFQyeDrLZuntIpAGxPreAceE36K
 jls8xxWqy4Kn7ZOvdX7YdhjqZOoCTiUe60g0HcaP7N5+DALVEAmAFPqGm/hVlxI+sR8B
 26budjB0tWD+teU67giNt1/02PckYHSCH5RpIKBlktL+5isOx0wKNSpgZb9u8vhUDIXy
 p0qIHKEf41UKf+7gJSyDgXYxVJr2OPsc6FaW3nxS9G4d4JLr/EFnQ1uSjsZ5WaapIztN
 Hcrr7uinIKwqRSFlWbILsLg0Y2QPmIAHvYOpNz5ZB49u599iRuMlSPB4+y+tJHaY0GK1 Sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=35fkW0H+8F5do+Nt3s5kznxvYBEy4Ui104J8H9GGEqA=;
 b=SeiSFwq/3H25BeqM4dD43EDT6gcMuogGprw+TyVtRh3dDe0yinh7xgPJVwk6KGX8PU8T
 P4iaKqHxn6xmDG+EKCASx5qYjuOf4q0Dv+X2YVfe4GJAnA+dLzyPXbcE4833Khiva8TG
 1F17naaBQiXq+Xc/r0/F1odj6Dt+uxtMFlRS/QVhJ3+idMux+lllclok0yInCueLuaCY
 0BIITgd8FFhv9Z8P+8YudSPIYQY9VfUyyMu08sSxWKaDMmkmq5err3TTIQATySnm4rkl
 F+kuF0QdH2o5gxedsyqQDfSZuxjGitgbJdQ1c1ASId/pssJPouRgs8PYqqzWff8k3+Mv KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a488da3dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 19:52:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16UJj7FA121825;
        Fri, 30 Jul 2021 19:52:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3a235a5bwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 19:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SznlPOxyXxWirg/IdSt2eC0gbcsA8N/f4YwHIoH4jUsATFYvptVxs4BYBIXP1teNwzOt6TZUgxd81p6DdtKHCKHC8FNqgsL/YQZmB9OSHxJXD5Q5+Cd4amv9qo+yg9DopP5fYHzkjN/DFfPK9bTesna7qbDdHoidt7HMkCJWSSFy5tssUIoqnWgCLFeY3CkWdHHvQ5rMCnDlzWOmzzW89zkOJ7Z+1w7wgIaYm/5ucD6++4OWUW0xJOsU1us+3tLxvqp1qWh1GAaFyad757DX1w9mBvUEtLcY4HlT4CFcO10I0+FUKfB2seOhGO4GAxm9gr7cOuNrFy0T3OH10aYetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35fkW0H+8F5do+Nt3s5kznxvYBEy4Ui104J8H9GGEqA=;
 b=P9LLgFA6EG4rFo5peVI1bN5R+tlXTDOJag6iPpdu4iSh2F0DbxAcFE1MoXjhaqVPsCjBcKRpa1A535kucKN4L35uv7/nj9HRvGw3qF+/UgXt0jxYK8HAVBtq4CsA4HmzCtTjQtR5lRra+/3V6qHLhyefpwdp0pe4LNhlpsX6lc3FYjNu7mIT3K6bUpr3hEW1i/kdFcLKQ6ugjfDKckxbNHLcCwI9nFPbpvKCRLUc2xdosz5L4pafme+T60V/FGHxd4qdQDuvx2fnoeRvUdleP4o0Y5bAeL8vpkoolctX2+8sU0yjg4BfjE0RO6i7rY9p+GOTre55fhakJ8TGSWyUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35fkW0H+8F5do+Nt3s5kznxvYBEy4Ui104J8H9GGEqA=;
 b=GGa1ECQMfU1hvHZFfYOjPso4J1prtheCqUxaxdzylI8648etFxnOUHchUHsW/MOnb7o58NGW3GzB6dQGnoIZekcQImDwMfx2bo51igMYPXXULSm8P/EuW2a0tL8lATioB+VHtvNucXq++ZorRfjEjS0NO0D2O4I+Kk5CsUOarFg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 19:52:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 19:52:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] XDR overhaul of NFS callback service
Thread-Topic: [PATCH v2 0/7] XDR overhaul of NFS callback service
Thread-Index: AQHXebMTaSxcscBFIk+X10jNgh8JrKtcBXKA
Date:   Fri, 30 Jul 2021 19:52:28 +0000
Message-ID: <02B12E59-E014-4CF6-9A5B-58E5F426F964@oracle.com>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e22dfc57-6eec-4b21-7b2c-08d953938f9d
x-ms-traffictypediagnostic: SJ0PR10MB5648:
x-microsoft-antispam-prvs: <SJ0PR10MB56482D16EC972F51766E25A693EC9@SJ0PR10MB5648.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVRzgJiYkOWq8LWHtiQDwOMkEkH0FR46mHS0IyFiYnHzWr1U++a0Po9/ynKsdB2yF3aYNPAHvkoaqUuMy5ThmuNeyUBF88hC5TrUmA4cuBLRcRU8mABs91FBtPTLVWCbP6Ci2Sv2Gissxjfi8Rg7EjE2zvc+2Ko16W+fnr/by7wRRbktH3vI25LYaHHP+XBMpjrHN8XVtZgYGzhwCFl2jp9ABHXZHpCT1tJIB8hPpVjfzS50MQas36hImZAwwGrrfrw1zwbzHnAVBdH3QmoM3fC49xvBWIzq/Juf/Y92+JCqZ6eAU9Pv5JsIsUrk1ixlPcgNR0NkUBn2zo1ZgcmOsIB0SShYkLsXj9Re0yBkV/kLPKvuAc8WhzOiyjl2OQgOj+ylrGJX/BRLsocYZLjDJQS/5GrLyZeHJQz/dZaluMAIMMzW92M6FJC2+SIWbVGjwox2BAn8SVoHjvLQ6++yGmB/hnyLplBQB59urTDC0NmuDs0FGTMVNot4MHJxJU+7bWNcEcghpfWmObNyRLf80GatmqCTDWiT78Ao1G1j0HnMFOKky/WgI7vmba+DkjAhEF7UhoL5Hn9VoLW0dtZGJzjZhbiiKwTBBvnRUC6qAJG9qyJWb85dA9+mSG83ScG20dZfzdlXdPnSzp2Kt81Hy7bDVVZPnRlaSqk8Fb0xqHzx58Ie0dNBebkqafJjsbCHCG2MGADEDxT4JkmpkQXjp4u2SwfkkXKmut8b6nt7EtQMRb5rvVqhgBqXu46ZIvycG3Mvixv8aHzKKPsL0RdmUaksFZ7WZAcMZurmRMKQ7crwZ6m8fd+BWJmDBQNLpacW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(64756008)(6506007)(53546011)(6512007)(186003)(66476007)(966005)(316002)(8676002)(71200400001)(66946007)(66556008)(76116006)(91956017)(83380400001)(2906002)(66446008)(478600001)(2616005)(86362001)(33656002)(26005)(6916009)(6486002)(5660300002)(38070700005)(36756003)(122000001)(38100700002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lA46NVGaNxeavar/syyuko69UewegdE9m4wxIgrjut6ze9DvDmC44rj9RIn/?=
 =?us-ascii?Q?r0t4Es9SoYQeHmMUmGl3ADxF341CNKUctQ/mzqm2KRSiMi8AESg1uVgnqeUo?=
 =?us-ascii?Q?UVRzAduu3kPp04xN/YTN22cZGHpDfgzFnXlOTv3hidmjmnY1biECc4pREpvq?=
 =?us-ascii?Q?7vwTQz1DKLFfPwwNY/TpAY1cdQr5mZf4Wv3cdFD49OAZEb/bLED4EX24QSt0?=
 =?us-ascii?Q?893xivTZD36kIzIF4dpSLM5sGNFj4zdzlHfG/Nt+e5YtFoq49kHKCc9p0vCI?=
 =?us-ascii?Q?VHx+lG7FP8Jy3Asmlse3u1dwzADdH6+XOaasAf328wSzcHmtUI2irvLyOnBs?=
 =?us-ascii?Q?dljwGL68aBicaZT2yOs9qxVPpbI/jRNKQryRWTK0sLKnuW/8nLMmKc11NVzn?=
 =?us-ascii?Q?e8vZMKmHhBtWRrCgxzqAafYpNo1dNHPj64xdVIOqSkG3znkmeqirc9TKBQTn?=
 =?us-ascii?Q?OdWNh3RCCGWCDYeFTP+To3bRn9IS1NMyuTHCGla47U7QUixNLHRGTezYYoRj?=
 =?us-ascii?Q?OYHKcg2eKVaDqYSUDWrOcGnUnJlY6sJDEAjazKLGu4TBB041sM7hS41SFZ4Y?=
 =?us-ascii?Q?DUwIIUUYlb/4ttZY+fXggGobArGdsXQXu9jjHcv5PHSr24xF1pugREo8w7KY?=
 =?us-ascii?Q?O8d9Op4dKo8Qjx6xhOLGp9VwGsyYqUqEd5mqsadailf9XaAVa8Xswvs9iYWQ?=
 =?us-ascii?Q?3AqRABAXlBEX5E6cA30565uhBxw5cFQ8iUgTgZXNav4O7dcrIX8QivgyteDd?=
 =?us-ascii?Q?g8hAIlvatbjd7a+XF8jRguxHRCoJ0dNvt5Aenm3e5p9qIdW6RLlVmU1sjixs?=
 =?us-ascii?Q?BIjcid8CyitU9TNZO9cPGqZ/j9PfNEiWi9DcMOJ/pEp5WiLVwM+OIkf5gTbM?=
 =?us-ascii?Q?8QXNiCgk5lzXuR2TZU08lxVrf0vHQ0aL7dk/LhkoD0tUp0mwQ+iqyE0AQe2j?=
 =?us-ascii?Q?Hu+9VY6cfv7Ni+bSwf4zABmAP8qiCXDQRx18i3TiFP6ylh3eZSlKmEkker2/?=
 =?us-ascii?Q?osRwmWkGaQCIFROz87A2zW7VojOzeaYMu2+Ir4W4et/mrzvkIbEMgR6smJWp?=
 =?us-ascii?Q?67tw2MMxHOZvUYzXedmRvyqgdKVF8UL/a02Nq399uf6ztr4+9hBiMVnrTpe2?=
 =?us-ascii?Q?HJG0ucSJ+YfcXIY57C77ZsSY91kOOdDG6k8MRjAiRffPH1rHHSXr5sDhWfbf?=
 =?us-ascii?Q?k8F0VqZo8aD87wBa6v40bYFcAziOsZRtYCPf4d24a6DUEwW55wEM4PNNf/W5?=
 =?us-ascii?Q?NqDBL0MAXNJTpDAxDDUwKA3iBENAHl07jPhdJQxJt9NPBoQEe1SFMbP0C0Pq?=
 =?us-ascii?Q?UXiJOA60pRXCuSuvsVtjKRk6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B166CED00475BB4690DE0D3A5EC4D206@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22dfc57-6eec-4b21-7b2c-08d953938f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 19:52:28.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j6ldByM3kAZWSihdjP0gkqRJA+t0Q32KgqPPb1/uzxa1272JzD8Tt1AxZ7A6O7lt12XCo2z7WBvmTyEilhe0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10061 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300135
X-Proofpoint-GUID: yVzLTvE7xgB1P_W0vdMp5YQyQxWYHMcR
X-Proofpoint-ORIG-GUID: yVzLTvE7xgB1P_W0vdMp5YQyQxWYHMcR
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On Jul 15, 2021, at 3:52 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> Trond, please let me know if you want to take these or if I may
> handle them through the NFSD tree for v5.15. Thanks.

I've included these in the NFSD for-next topic branch:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Df=
or-next

They can be removed if you would like to take them through
your tree instead.

If I am to take these, Bruce and I would like an Acked-by:
from you.


> The purpose of this series is to prepare for the optimization of
> svc_process_common() to handle NFSD workloads more efficiently. In
> other words, NFSD should be the lubricated common case, and callback
> is the use case that takes exceptional paths.
>=20
> Changes since RFC:
> - Removed RQ_DROPME test from nfs_callback_dispatch()
> - Restored .pc_encode call-outs to prevent dropped replies
> - Fixed whitespace damage
>=20
> ---
>=20
> Chuck Lever (7):
>      SUNRPC: Add svc_rqst::rq_auth_stat
>      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
>      SUNRPC: Eliminate the RQ_AUTHERR flag
>      NFS: Add a private local dispatcher for NFSv4 callback operations
>      NFS: Remove unused callback void decoder
>      NFS: Extract the xdr_init_encode/decode() calls from decode_compound
>      NFS: Clean up the synopsis of callback process_op()
>=20
>=20
> fs/lockd/svc.c                    |  2 +
> fs/nfs/callback.c                 |  4 ++
> fs/nfs/callback_xdr.c             | 61 ++++++++++++++++---------------
> include/linux/sunrpc/svc.h        |  3 +-
> include/linux/sunrpc/svcauth.h    |  4 +-
> include/trace/events/sunrpc.h     |  9 ++---
> net/sunrpc/auth_gss/svcauth_gss.c | 47 +++++++++++++-----------
> net/sunrpc/svc.c                  | 39 ++++++--------------
> net/sunrpc/svcauth.c              |  8 ++--
> net/sunrpc/svcauth_unix.c         | 18 +++++----
> 10 files changed, 96 insertions(+), 99 deletions(-)
>=20
> --
> Chuck Lever
>=20

--
Chuck Lever




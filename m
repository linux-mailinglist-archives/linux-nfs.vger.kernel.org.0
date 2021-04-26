Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDC36B587
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDZPOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 11:14:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47448 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPOx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 11:14:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QF5qPB045536;
        Mon, 26 Apr 2021 15:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dDdwPYEepzXK0ixwPy+OUp0hkWh1i/5iv1uxlPQvVL0=;
 b=os0iUvlL4TKdKwGpn4X81cBC+Hh2LlQPuG3MITcn67NvGVSbMvIty4Fl/sZiRkxNss3w
 Hm8Th5BQgQccpwVCWUFyhyl5W/g7JLx/KObri+nDk1loGbgvBvAV+ZD3T0/WjyhI1GON
 DWMOwZF1tbx7QpImoeseU5IMbBeZo7gWPYDvRKoEEg4rXjC+B5DAmJy42NH6595z/o2O
 dM1BN2kQsnQYSV0wu82SsHHfidGLDvbBjS+V5muHJdDldoJZEIB1ypxBukn/fcuTMGYG
 zVgl/XjSEOjws2+8GNSs+2poa1aGa+kwQC8XtdBXxQxr/MPKOjPaKpnhJZzPCvt0lxmG EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 385ahbjd4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 15:14:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QFANGY028911;
        Mon, 26 Apr 2021 15:14:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3849cdb2j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 15:14:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOG1+mnnnuqKltUPjFS+MkUQ9sKebGUOnHmcbIsmjYluugVCKV6D0yB9Snt5bpE/j/VkaErLgLwPIfJlYX7nSv8TZgfiS+tTIKHSGHkq+6Yl4oHCuPO/pHZqbZpPv4x7O4PzluwuKLYmPQxXTzW/SPMvxop20AEzQUCVmQtuc2HPrYm2GNa8F9TeXJa7I03zB0BXCrVBF8tqS54aCUrlF5VFlgVhmy74DqAu4NBVAaIHmMDXg4t7EZEpMmTKTq/2W2Iy7HX+PI69TexSIwWuI5xTE41st25UV5yNwfiAEuWmZFN84ShNa45o9T3mnhpUPbKlOOdiiT9KYQ1m/aibYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDdwPYEepzXK0ixwPy+OUp0hkWh1i/5iv1uxlPQvVL0=;
 b=AQNYsWwA2WjMvPrT5BxPn4ROtwEC2of98yVAN61zp/hPlkqKfeKab18snKEJjJQqNgUcHcUr7SEPo+6911tJqvC22Q9qEX/652ezbpslIOzc4hg64pAiX+7sTFEZlSHPTAL4W1LJA3c1WXVavjWms7b6+FVQR4kul/IFzFGuoi5QI4A7LUjPVo8cgmZ4CjxOb8TsuJ1nttMvPHuV5nCdTc0JaQMtGmKCYWcNv+TG7laEgvNpfSiWz43ndkxmPXzsfewFWQc6eCzpDbWIKvRujB55kdhBMi6gZnPhzJZYjF9kKsc8j6VSMVjhX1fPjDxSYgPJM0sJtmkkyKHdVxkaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDdwPYEepzXK0ixwPy+OUp0hkWh1i/5iv1uxlPQvVL0=;
 b=AQDA+8EkK4JhWUXTDA9HO45ArktkehiCSBJFde9QYXoDYCFFkfl3XFNIsoNnU/1TcUMtynGr3pQyiu6sA9n/XcScaT1Hp+VrwVIekgvHzJX9cn1SbmOegcKswk7Rtrg+j7bEKfFJsIkjgS6L2ZDTplWZ6h25WxzTKTI2L/fJNco=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3384.namprd10.prod.outlook.com (2603:10b6:a03:14e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 15:14:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 15:14:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.13
Thread-Topic: [GIT PULL] nfsd changes for 5.13
Thread-Index: AQHXOq7MIygIWsZRwU6N2zHEZnNggw==
Date:   Mon, 26 Apr 2021 15:14:05 +0000
Message-ID: <2CAF9044-0E80-411A-BCDA-D90A465A4C27@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c53543cc-4599-4b2d-960e-08d908c5eef0
x-ms-traffictypediagnostic: BYAPR10MB3384:
x-microsoft-antispam-prvs: <BYAPR10MB3384C32CE687BCD5F7B55EB893429@BYAPR10MB3384.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2Djc5d4kVWAHq8Jlkoou6j0pIzQkPGmwpoKiN9NCCc/iBUdVlJ7QTuQcHG/cM+qa0QRAcfUkP+46dBrNQKtxPSXelDrV2yN5nsRpqIkHQPcbtm7LrX/LD9lKYj89Jtr8/SouVjoXVkY3zJMmklNaF3MGomm81M+RHmO7szXhWogKtay/NJ4STadDjICH+ktEKZ4cwezaB5X8xDfEqBdRQw+me9iydpvmiE+wtBjGSPLneAdLxdpbMzY91eu5s7FcbLT4SxO87Eecba9tutXZLuC8EFylr6K1BnxaASC3vrMa8Wfzrc1+DlJlV+3yZgU0JIX64v6uM1H5nSVu9EH0hq++8rgbFg8i92+jRzosfDMNYDUZDPItSn1ae8idT3KzsqGEiWxoQS564HBCoMjd0i5/d9zKOBRBIdGR+HgsT1HL3UQevPxQgd40BY05Cr+WDoMhbunf93kCL3lI+zl4VZaajA6DDoK5P3HVvzvIGMfu+jn9IYRAkJ3C0QebmBHaqDZArMSCGdrtnJ+UTAm+V2TXNVGOY5pUyMNxOksjooIPBc/MdW2NxHZSRyzDjl5YZhr8pljLKV1vKlqPzjEs3JvzfWb+RAiclKBhdcHETFBA8mducN1X6QljEHE7Gnb1Iqp8jwyUT/BAl2u1EgAZU6mHzFA9O1UWlBFZvPXbR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39860400002)(376002)(366004)(8676002)(66446008)(2616005)(6916009)(54906003)(86362001)(2906002)(5660300002)(316002)(26005)(186003)(478600001)(6512007)(66946007)(8936002)(66556008)(4326008)(66476007)(122000001)(64756008)(33656002)(76116006)(6486002)(38100700002)(91956017)(71200400001)(36756003)(83380400001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MLf98wYOzXaHl6RbMw4Ral/wIdG3ph1KNGC17oegmLdDd4h++45pUClqyATQ?=
 =?us-ascii?Q?2FJ4wLFtPYHReUg6txseJyLaDamn4ILo4zoVpMsVCQ37HD0e+X01fRjeworj?=
 =?us-ascii?Q?SQIoNWOBMbi0sNHlg82RtVdvUsbB6xSVx1LwMaVilcrTOvBH27NtrpzHsKV9?=
 =?us-ascii?Q?vhpeHKaXwvR+6VrLavHeQNS0ePYyWN5avqO3g0nwM0TQ6HGBBzoVTYQ1oI60?=
 =?us-ascii?Q?YDgMNDGhaggPzO84qJn7cPpyaMbs4xc5pAsDF5X7N2O0dkpaTXqrhamm5NTI?=
 =?us-ascii?Q?ZZcqrtbrg52nTUdhpq9dSB+3Y5G3HYrjBd/pXVsgc8Zcq+s/z5VtZliKWPio?=
 =?us-ascii?Q?e4qyPft7lXVyQIhcIVDpP4sTTdEFL7U/tygLtNJJyyeu4rqjN9EJqw78F/lw?=
 =?us-ascii?Q?SsourOiBTR3Awgw1G+zkcVdP1+T+7+i8AoLNkEL6guLepNJX9T4BhDcKSawj?=
 =?us-ascii?Q?VbXZfbpjiSqQuJfmrZYzZYzZ9/0jgPkryYUBkKD2j9fUpoiQpFCjFpXNhT3O?=
 =?us-ascii?Q?fimI1LUaXQf1kCX9SDx0dMRDCFpezIZsuo2ZwMz6BK3mH8jVeqnt+6FPd8he?=
 =?us-ascii?Q?irs4dPMR9MeUY3cYa0NpicE5XyIezwNd3jFRtN8DDc032hzy0h/z2Ob8wfcV?=
 =?us-ascii?Q?Ku2ca3keoFDDOMhocuQXARhZ1ZQ3VuTGv8Eq47KIq6clLlO4h7NGpcDYWX9n?=
 =?us-ascii?Q?1jJd5AZWiYzk4naHbrmNpxbpNAsibzh+EOufvuwtZ1bOtD50dVGZAAqQwZo3?=
 =?us-ascii?Q?dV0kUhxUaBfCT8oedvWrWvS5YrPdj/CqP0eNUVaysAmAlLxge9N9QE5QYhUP?=
 =?us-ascii?Q?I/m7Wpf+EpXAPL6YBJQDJWC/xJjgPYHnZ7TEABxoSefDI/mQkkhYrTlI1hAC?=
 =?us-ascii?Q?2qnjMaKDvYbi79Ipt578HkE+pAIUoxslxNesqCN3OaPsEVACDTSQa6P6qaxZ?=
 =?us-ascii?Q?GzDCkzhuom+uBWUmpYZCEg6RyXq8+m39y+JfJIq0A6209SghtAK054spBbKt?=
 =?us-ascii?Q?bsyY6k7P9H9HQskxiNWU04Bos8lwZzaLY4DIma3kp3KETWCmk+SDlx6U9NYX?=
 =?us-ascii?Q?Pg69i2ir1A2YlNeH7jQOw/JcmMEuCGpinp6fKjW9VOUHMwV6HWH6l0Si47DW?=
 =?us-ascii?Q?XVbdPdqgMxVNZGQqnMj0cIHHok+oab1iIlLe4WDhYKiAWUaxNrhBTuzJ7cSy?=
 =?us-ascii?Q?z7DoiOP0YLbJVdhhbtGi2rMEj3UZtHyV3+EmbZseNGUpyIpm6kd2fLc/TH1k?=
 =?us-ascii?Q?tuj2ruC03CUoogJ0K7uSNfxi+6EpHHV5pnGVMbMWT2iAgaNjTzRm5rimvEiU?=
 =?us-ascii?Q?ZDAqMORnSGHE8FHGdy4bdhGZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5EBAB4F682B1B409708733B49A6EF0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53543cc-4599-4b2d-960e-08d908c5eef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 15:14:05.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18mxjA60SIM8GR4r8cCyUwvOkdxLnIW52HBfSNJXDbjNZM+ERKcZrgTbIWeUUNy9oX+3Cp04/XLrLo9vEx0c+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3384
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260120
X-Proofpoint-GUID: u_orZ70RkcmtSomAwo6c-QOKP3TQYLy9
X-Proofpoint-ORIG-GUID: u_orZ70RkcmtSomAwo6c-QOKP3TQYLy9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b=
:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
3

for you to fetch changes up to b73ac6808b0f7994a05ebc38571e2e9eaf98a0f4:

  NFSD: Use DEFINE_SPINLOCK() for spinlock (2021-04-06 11:27:38 -0400)

----------------------------------------------------------------
Highlights:

- Update NFSv2 and NFSv3 XDR encoding functions
- Add batch Receive posting to the server's RPC/RDMA transport (take 2)
- Reduce page allocator traffic in svcrdma

----------------------------------------------------------------
Chuck Lever (59):
      NFSD: Extract the svcxdr_init_encode() helper
      NFSD: Update the GETATTR3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 ACCESS3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LOOKUP3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 wccstat result encoder to use struct xdr_strea=
m
      NFSD: Update the NFSv3 READLINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 READ3res encode to use struct xdr_stream
      NFSD: Update the NFSv3 WRITE3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 CREATE family of encoders to use struct xdr_st=
ream
      NFSD: Update the NFSv3 RENAMEv3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSSTAT3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSINFO3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 PATHCONF3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 COMMIT3res encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv3 READDIR encoder
      NFSD: Update the NFSv3 READDIR3res encoder to use struct xdr_stream
      NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream
      NFSD: Remove unused NFSv3 directory entry encoders
      NFSD: Reduce svc_rqst::rq_pages churn during READDIR operations
      NFSD: Update the NFSv2 stat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 attrstat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 diropres encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READLINK result encoder to use struct xdr_stre=
am
      NFSD: Update the NFSv2 READ result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 STATFS result encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv2 READDIR encoder
      NFSD: Update the NFSv2 READDIR result encoder to use struct xdr_strea=
m
      NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream
      NFSD: Remove unused NFSv2 directory entry encoders
      NFSD: Add an xdr_stream-based encoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL GETATTR result encoder to use struct xdr_s=
tream
      NFSD: Update the NFSv2 ACL ACCESS result encoder to use struct xdr_st=
ream
      NFSD: Clean up after updating NFSv2 ACL encoders
      NFSD: Update the NFSv3 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv3 SETACL result encoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv3 ACL encoders
      NFSD: Add a tracepoint to record directory entry encoding
      NFSD: Clean up NFSDDBG_FACILITY macro
      svcrdma: RPCDBG_FACILITY is no longer used
      svcrdma: Provide an explanatory comment in CMA event handler
      svcrdma: Remove stale comment for svc_rdma_wc_receive()
      svcrdma: Add a batch Receive posting mechanism
      svcrdma: Use svc_rdma_refresh_recvs() in wc_receive
      svcrdma: Maintain a Receive water mark
      svcrdma: Add a "deferred close" helper
      svcrdma: Normalize Send page handling
      svcrdma: Remove unused sc_pages field
      svcrdma: Retain the page backing rq_res.head[0].iov_base
      SUNRPC: Export svc_xprt_received()
      SUNRPC: Move svc_xprt_received() call sites
      svcrdma: Single-stage RDMA Read
      svcrdma: Remove sc_read_complete_q
      svcrdma: Remove svc_rdma_recv_ctxt::rc_pages and ::rc_arg
      svcrdma: Clean up dto_q critical section in svc_rdma_recvfrom()

Guobin Huang (1):
      NFSD: Use DEFINE_SPINLOCK() for spinlock

Gustavo A. R. Silva (1):
      UAPI: nfsfh.h: Replace one-element array with flexible-array member

J. Bruce Fields (3):
      nfsd: helper for laundromat expiry calculations
      nfsd: COPY with length 0 should copy to end of file
      nfsd: don't ignore high bits of copy count

Jiapeng Chong (1):
      sunrpc: Remove unused function ip_map_lookup

NeilBrown (1):
      nfsd: report client confirmation status in "info" file

Olga Kornievskaia (1):
      NFSv4.2: fix copy stateid copying for the async copy

Paul Menzel (1):
      nfsd: Log client tracking type log message as info instead of warning

Ricardo Ribalda (1):
      nfsd: Fix typo "accesible"

Trond Myklebust (1):
      nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted

 fs/nfs_common/nfsacl.c                     |   71 +++++++
 fs/nfsd/Kconfig                            |    6 +-
 fs/nfsd/netns.h                            |    6 +-
 fs/nfsd/nfs2acl.c                          |   89 +++-----
 fs/nfsd/nfs3acl.c                          |   39 ++--
 fs/nfsd/nfs3proc.c                         |   97 +++------
 fs/nfsd/nfs3xdr.c                          | 1057 ++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++------------------------------------
 fs/nfsd/nfs4proc.c                         |   40 ++--
 fs/nfsd/nfs4recover.c                      |    8 +-
 fs/nfsd/nfs4state.c                        |   82 ++++----
 fs/nfsd/nfs4xdr.c                          |  110 +++++-----
 fs/nfsd/nfsctl.c                           |   28 +--
 fs/nfsd/nfsd.h                             |    7 +-
 fs/nfsd/nfsfh.c                            |    2 +-
 fs/nfsd/nfsfh.h                            |    2 +-
 fs/nfsd/nfsproc.c                          |   53 +++--
 fs/nfsd/nfssvc.c                           |   42 +++-
 fs/nfsd/nfsxdr.c                           |  413 ++++++++++++++++++++++--=
------------
 fs/nfsd/state.h                            |    4 +
 fs/nfsd/trace.h                            |   24 +++
 fs/nfsd/vfs.c                              |    9 +-
 fs/nfsd/vfs.h                              |    2 +-
 fs/nfsd/xdr.h                              |   23 +-
 fs/nfsd/xdr3.h                             |   37 ++--
 fs/nfsd/xdr4.h                             |    2 +-
 include/linux/nfsacl.h                     |    3 +
 include/linux/sunrpc/svc.h                 |   25 +++
 include/linux/sunrpc/svc_rdma.h            |   11 +-
 include/linux/sunrpc/svc_xprt.h            |    2 +
 include/linux/sunrpc/xdr.h                 |   34 +++
 include/trace/events/sunrpc.h              |    1 +
 include/uapi/linux/nfsd/nfsfh.h            |   27 ++-
 net/sunrpc/svc_xprt.c                      |   34 ++-
 net/sunrpc/svcauth_unix.c                  |    9 -
 net/sunrpc/svcsock.c                       |   24 ++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    8 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  178 +++++++---------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  111 ++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   69 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |   15 +-
 40 files changed, 1609 insertions(+), 1195 deletions(-)

--
Chuck Lever




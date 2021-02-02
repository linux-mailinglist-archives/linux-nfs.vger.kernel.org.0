Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F311730CB63
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhBBTWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:22:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbhBBTUW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:20:22 -0500
X-Greylist: delayed 1703 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 14:20:21 EST
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112IDajH036310;
        Tue, 2 Feb 2021 18:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7q6ot9DhoStcd2NmePEjmjFufyAvoI4M5A0gyc8Y6iI=;
 b=En0C7c93wp1NBOkjxzrkUg0D2sPuS/qnvuOmhsgct53lHM7dhRbpd0zKX5/B23SW34Z7
 sTC3He5GPf2eHXlB4kBNGZXtuYDCXOmfBGoZ0tVSnknsS3whQ21B+zLSP6k9U5nzBMQ4
 MZDR5AGpKl4knFArp83rFUirPCCrjZ4xH3RqH6HXRgceqJqVx4yWYgGjxixmUXl791sC
 kh23bgPfIjIPEohjw34hJ2Scu0OVoL5gFyX8+a2w01EvFufdbSF3CAjkV8hnLWLLxlaw
 DDU3QOqxQIxjIJoIWnXAL31/S5ToTl/f3QWUY9lbRYGNCmAkeoOFx3G604u8dShaz4MK Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36dn4wj82v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 18:51:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112IGaDN104579;
        Tue, 2 Feb 2021 18:51:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 36dhcx6uws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 18:51:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP3Nl0edLbIgjrguIwM7Dzq1OsDxZURjqMJVob6TXBzkNh+bHKj9oES51VGjv+rtvPbtunwewXS20UJAinpyIKV6g9YAwSuVuU02RnAFbxuRox2+NmtPZh0cIoNr6Vmbij485VdIpPZf63K+SW1QNk9UyjDoH/Ofw8pseSppE+50aB2AP8ZIAh6cP8oW+94hcsa6t2P2VracDPlqrcG3FZSMmSiAYcYzerW3UTe1ObqMP2TzBb/yDeyfs3XkYqNqn6lZmV7Lk0s+kckrG2J37SkdqmHY2Am7Q53QPMIfJDAnC2gGBkPpC0bDMbNPCHoljP6Os3Jzo/cQYA5wFtoFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q6ot9DhoStcd2NmePEjmjFufyAvoI4M5A0gyc8Y6iI=;
 b=la6heNrOvtH5voBt/wLqwnsql2uf7MmPeQmvAAycUnhOtg2qPbagUYbljLdXQYvvGmvCJwfmpgls1t8pYVNQR9cwOqIEDj/Bt91gxCDaMupFrrcqEVLPBmok3QqO60LSQOJU1Byz9oW2kEj893wjdU03Covysv4wjAvBsHgECvOB6R3Kq0bXbHMvwJuuvagDluUAp6nGB8KG3+P3KKrXphTcu/WYy+8E6BTjQuqETDY35wc0f6SLRRLWOctzKAi42MGSWCm6poksJz9dzIckkRYVOt/38eOUoV7My4+z8M2Tq2wbKtG3en2+ustWk5HymOxnjhdKcUUuZYVp6EHC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q6ot9DhoStcd2NmePEjmjFufyAvoI4M5A0gyc8Y6iI=;
 b=xR1TdTO10zWqqPyfDAZZvdWP+23bu8wDGZcOTFmxdIvc9tNTvMYFaOxCqWgU4ybvbv6twqYwfIlEsDEwIG1aMWZOVqu1af4U9IkJBVAVHFwZtOYPSs81py+FHvMPNsKF2dh7h36YaMpT9qZqENKUkFn0NFfljNaXab7yzn1gPsE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 2 Feb
 2021 18:51:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 18:51:09 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Dan Aloni <dan@kernelim.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZPDkI44uVsPcUiYIRmrZ1p/T6pFNZQA
Date:   Tue, 2 Feb 2021 18:51:09 +0000
Message-ID: <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3409b61-8bef-4f57-e065-08d8c7ab8140
x-ms-traffictypediagnostic: SJ0PR10MB4623:
x-microsoft-antispam-prvs: <SJ0PR10MB4623FD58C70A280D1FB97A5F93B59@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LX/7p0VToFo7O2lrlvRVRyT0BCHvLMFJ94ZT/uIGEycelZBOhDXdqLm6+GqJanmc/uiNn3WE26fnWp6lDKZe1AVy4AKF3xpBCt8vQhQl2XvsH5hGdsU61WK5zCXbVpRfFu1wXtLFkjdcAnoQEGjEQDiDqs34YXJdt4tqywuWNuZiVBjh0fV5p1etuE1qfLsfpW7PcE31y/3p5zr6HdYFdsLGeuyj7y6LsnMjC+ofyHnRkQh2tpeKfz43ydNFFZC0rsrhKWjN6QcL2QJPLWqXOUryHDgELAWWgPS5Kx9o5Utj8RXfvCEEQ0G2GdYJLYgx9Jndywrs1L2tT3cefA44p5vr5MHOUiim9Tno0zh5xYMZf/htSgUZMImkTfmKBO3lccT2eQWTn22kDhwLJvogW9I+9ppVMkAey/eHelJpzUlN5s2B8W1y69sAmbcOikjLUMcm0uAH4BhCTcMOM+mYinKpLbUmyXNvpDCKuTsZMfHMSWoMaHd9d0z32DoSEc1Ahx4KgAUjJA9EB+FK8vm1T4H/Itme9QKteoe0lUe08Re6lw1s+Qk/LcRcITI+xpZrZYzLdqr1fH+ZjCNGMYW9Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(376002)(396003)(44832011)(6512007)(54906003)(6506007)(6486002)(8676002)(33656002)(2906002)(53546011)(71200400001)(4326008)(86362001)(26005)(5660300002)(6916009)(83380400001)(478600001)(2616005)(36756003)(8936002)(316002)(66446008)(66556008)(76116006)(64756008)(66476007)(66946007)(186003)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KoKAQ/RiAmAnxkhmVom22fNpAFJXqbYFkrXwvPRuuGzICkN7Mb1uyy/HKuDD?=
 =?us-ascii?Q?uBPNzSGoYGCKCrKFt5mYPGHccpx/FtrNhMUWd9yuiw2ggnqkKlb1R59C3/ye?=
 =?us-ascii?Q?8JepU5NdGe9mdBG5gZROc+HcSrO878T5cngAmcCetdQHpMclmbErlwghP18L?=
 =?us-ascii?Q?lvekY5s0V4hcvYOCPbqfQdlMDVazAG/Ec4tv3h5qT4pXBWdPewbSF+1mqdhY?=
 =?us-ascii?Q?kjPxqP5HaeHYyIugcW4aIg1H+B6hfba+wvb9fMbHWqRJYkmbvJrCwb12kyHb?=
 =?us-ascii?Q?EfsGe7x1F7Lx7mmaMOgOibA8Ek7MSbddAd/774MWB5lQzBkSS8QlCiQLIPhn?=
 =?us-ascii?Q?yXFgm2OEQLMIWiiwfx0dV/nydMwDrOJmDa25CtgY5072s3C+/7Ts/0fyb8P0?=
 =?us-ascii?Q?oANH1/u4/tr6R6M8A7854Z9r0k+Zbftd0MWjzG2IxpK1h4JYbpSyC0NPsM10?=
 =?us-ascii?Q?DX2EYYne+91qNHUGRHNXmTMWLc59t279meaGNkNDsewMO5f5ZlLNIFo6OIGj?=
 =?us-ascii?Q?/V9jqe08NnqlBKaGYbKn65tIPHWqXC5O5m3zPnrrL3FAZJzg76YXHkAZgx0X?=
 =?us-ascii?Q?20CT3lC1tN1JD3teWh/80gjQ7f/4pY/OpSGI9ORq4gpTdFSEDJtKfgbYfp+b?=
 =?us-ascii?Q?7qXqhnysq8NcxjsUWYWLrjW+u+PaPqfcAyh0jK28C3OFTDoQM8JZf+NMpoiy?=
 =?us-ascii?Q?TLuYTt6oFV9VwhE0uELVCuKwkVhMvvXB1b84W3Uedvssnrm3UK0bw61FqRcU?=
 =?us-ascii?Q?Ozifdd2m5Oesj/bD++h0hWt4Zw58onvrDdW1WsxTgEQkK1yQjTIpS02R9wUQ?=
 =?us-ascii?Q?v1Jei+54JXDw+oIGnPQGQJV7ppZXCTNON1bBfKgPD7B3dmWBYIJCHvCDBcKf?=
 =?us-ascii?Q?UfPURAoIvCsD1IYkAgLMakVgIzp1xqIrwU9A/Jmr0+40OGsnot//YbpAg8ML?=
 =?us-ascii?Q?JIoYtUdawBaoe3MTcrRjEuKRIwHN3Lm69sNCD8aohbXeUaqO99+MEodERXrG?=
 =?us-ascii?Q?C7OjWZpLzNzd+fi6kUh6tviEADRg57Re9f4oN5FPof7vl8rGQAhj6DjUDnyc?=
 =?us-ascii?Q?x+39HSQin6nsqYqs+CtJaOvW18gq2Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4804B212C6B5F42AC2496B53D20FED4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3409b61-8bef-4f57-e065-08d8c7ab8140
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 18:51:09.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wkk+kofJ6Bq4eENsHZMxScHvCo4GefgniMY99347ug8B1phx8yjK52lia2TnuEVJ/Q3IEyPtRdPpYUeB2c1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I want to ensure Dan is aware of this work. Thanks for posting, Anna!

> On Feb 2, 2021, at 1:42 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> It's possible for an NFS server to go down but come back up with a
> different IP address. These patches provide a way for administrators to
> handle this issue by providing a new IP address for xprt sockets to
> connect to.
>=20
> Chuck has suggested some ideas for future work that could also use this
> interface, such as:
> - srcaddr: To move between network devices on the client
> - type: "tcp", "rdma", "local"
> - bound: 0 for autobind, or the result of the most recent rpcbind query
> - connected: either true or false
> - last: read-only timestamp of the last operation to use the transport
> - device: A symlink to the physical network device
>=20
> Changes in v2:
> - Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
> - Rename file from "address" to "dstaddr"
>=20
> Thoughts?
> Anna
>=20
>=20
> Anna Schumaker (5):
>  sunrpc: Create a sunrpc directory under /sys/kernel/
>  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
>  sunrpc: Create per-rpc_clnt sysfs kobjects
>  sunrpc: Prepare xs_connect() for taking NULL tasks
>  sunrpc: Create a per-rpc_clnt file for managing the destination IP
>    address
>=20
> include/linux/sunrpc/clnt.h |   1 +
> net/sunrpc/Makefile         |   2 +-
> net/sunrpc/clnt.c           |   5 ++
> net/sunrpc/sunrpc_syms.c    |   8 ++
> net/sunrpc/sysfs.c          | 168 ++++++++++++++++++++++++++++++++++++
> net/sunrpc/sysfs.h          |  22 +++++
> net/sunrpc/xprtsock.c       |   3 +-
> 7 files changed, 207 insertions(+), 2 deletions(-)
> create mode 100644 net/sunrpc/sysfs.c
> create mode 100644 net/sunrpc/sysfs.h
>=20
> --=20
> 2.29.2
>=20

--
Chuck Lever




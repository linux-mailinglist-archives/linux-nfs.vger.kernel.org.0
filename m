Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2F30CC49
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhBBTua (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:50:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhBBTtM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:49:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112Jj1nB071562;
        Tue, 2 Feb 2021 19:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EAC4zFbsPILlYJ/LmDg9P/1GjRtw6Q+ZV+6KXzmEuts=;
 b=Lb4Ilwyzyk2Zu9ffd5XkOwhKVjY4lmwxbhQlT8PG8HIonCO1yD3l/7rk9YEwAZj85izy
 5a6+jK0EBsPGwW8yf+UEuAHgjwnPkXjlgy0nyKyC1z6N6aUTs6f9lffpcefgmoIbJc+3
 8gGODsOkQdg/x8WqxWjwNC/U9R55Y0aiEcjugUCP5iOYTKFtjbqBcuQLdPenXTUvV0Jz
 d0584zpJOjK3nB/LFVJTMeKhsvcuafY/WQJ2OfPJk05au8A2HacjbhWV/2ieS8peiOgM
 Bai5MO7LapWIteBoswMD+PXU2rqYFQswgBhOaRrGom1U05pKlTgVpOgfj70zFRtHBDVZ Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydkvk59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:48:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112JeEHj006308;
        Tue, 2 Feb 2021 19:46:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 36dh7s307t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKSL8Tu+Wukhy+wcM6QmBF5XkQXdlQ1V+TwF0eaitN9mjXN/oj21vniWEC7jeoubIZIfD7UqiPnkcgIZtr4VH4MoO+X466Y28MZrGKD0Q/yvNr/MDoIfj8OgMVnYbg7YlII06/NHcbluc8THsIfZYDNxWJK9QrV8fNebsAUPi/WzOiWQQbP8FyNggkQNOtHueNp20+0/ju72eJ4mLXX87XKSsQi7n8TGQQcYcAcJFJG7YBojEC8atqOp563uf/oZAf7vN1cGBPRGNOUDNAIySl8U/533n/wjlmD/3sTJSo00/tv7XG09hlguv7OGsRuQnuB9wTl9BHwgxN5QCBpXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAC4zFbsPILlYJ/LmDg9P/1GjRtw6Q+ZV+6KXzmEuts=;
 b=ISBrOGmRvxnd5mZUefLs3ViOB1gHe5hsnPmqOLPGAUsiomupl3pCMQRnW6637A9gHeiLcPQGcOmgsXUgyFLFjHy2zZerHPA81mrvgdmQtpNCy25Z/7xdXEtlRm3Qy64qWkP6qkVVSMTA4jghV1WH4az/xa6aP+0mYnGMw65TcUIK8IKxcO/Kf7v15pXYr1dla++y47nv9Hnz5Bg0JRsDtXIqtFcPpoF5ZvWEzXY+WyUlPRg6SRro6Zs2aG8gHj/aPW2PQyBYC/KM6JpvNSrLj2SyDzDcIl05gYNAdn5HNxq3NUF2S1vEwqF4sJBS/boFTJsIoBazxC4pPEFmShtYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAC4zFbsPILlYJ/LmDg9P/1GjRtw6Q+ZV+6KXzmEuts=;
 b=DZG9IwQqGKJ4+3zUlSj0Gqm3sx1Gkfbf3Orvc18nWA/n0mDoGdlIE6/Kij13zYrNmnWm/u3rZogrc5sPMgdWrL+Uqk/ZgCiINj3QKotqDECpJFCeifMSyV2/u/FYimxzs7dP6MrQ06qP5OQBrvgBrdiG/iozn4fyi04dBVD+PLU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2648.namprd10.prod.outlook.com (2603:10b6:a02:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 19:46:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 19:46:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dan Aloni <dan@kernelim.com>, David Howells <dhowells@redhat.com>
CC:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZPDkI44uVsPcUiYIRmrZ1p/T6pFNZQAgAAASgCAAAj5gIAABikA
Date:   Tue, 2 Feb 2021 19:46:21 +0000
Message-ID: <FAFE2F11-5A48-4FD1-A475-F137616A4A03@oracle.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
In-Reply-To: <20210202192417.ug32gmuc2uciik54@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41190191-7918-465c-9204-08d8c7b3377e
x-ms-traffictypediagnostic: BYAPR10MB2648:
x-microsoft-antispam-prvs: <BYAPR10MB264873C6B063232BB5BB4F2093B59@BYAPR10MB2648.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qrT+PNyYMydcdG/WhmjcDjmxQ/Jd8zI9ByH1O3Tsve3NcnNAbjRN2sI7Xz5pQm+usJq/yb83WCV5iWd/2VZupGXRgFiuZ4s6D6Cb1u+vNmTV69Snq2gQStqWSi2rn5OxLYnUsIf19Ytyibfv3iVZOu6G/o+5thEK8O8H+e3PE1+GlYtPEmYSaLanGhlRG0y5FLgnu6jiWFNOn56BEtMSRkzE3xgpB7Zlae3gM0/N+GaaVWhOhILLlpmhqWMwyqrv7CoKsqV14V+1Xjc0gHXd3sc7rwX0rhefN6YNzRmPDkPeOS251Kyn7BDJboedE/Hw2Y8Qw4Y5k1eJ76XkUwBIR+jQ+BUK/XcI7b/Z3dXaYEuQnlCOVJj8ipaqWJg1mgevAL2AaF6CsK3GBtUKK1COXDzwr6LewPY0yaKwA7Epzq2Y6Asp3XM37HGiTbpYXe6+8pR5kT9xwYL0BmEeSFcafhwXGkauKsL2KLiEMO9b+nVkrLOxexqvC9rjTfI+KarPKy/1dMWm+8Fru7EsShKFICWQLqECcwF2fSTDAziYUWd4xuhY5cRmQnkhPrIprTC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(26005)(6512007)(2616005)(2906002)(83380400001)(36756003)(66556008)(5660300002)(33656002)(186003)(110136005)(6506007)(91956017)(4326008)(54906003)(316002)(8936002)(478600001)(44832011)(6486002)(66946007)(66476007)(64756008)(66446008)(8676002)(86362001)(53546011)(71200400001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VXtgbF4Wc6m/Y2EwbCq0bsxDmV/19CPf4ypHNs2NrQArrATUdG0LaRuCFRDw?=
 =?us-ascii?Q?cmRF1asRvXpghXN7mjVkCxkVU2MqH1dqsGrG53DKG7EkY6plvHAgrDaqRPTC?=
 =?us-ascii?Q?BS/PVFCbLRcnYzUU/u9zIZSw9A3AtkKHhDR5sn1i1/hRg587iKfJQGrcylTG?=
 =?us-ascii?Q?l3BizxQ9UfB3Frp/gOxJDTorCSlVRsiVlUv39zoBu4q7vu4yzUWE6Yac/kcj?=
 =?us-ascii?Q?eDQ39CEeKFMATtvUZRlDLH+Ax3h/AquqfOv9/9db1cITRq811TCRtkkPVGOJ?=
 =?us-ascii?Q?mII6k27a8RjSNOMShd7pHb2md0taRCHyFpgA+QDKMl64SktIbrABz25GuvZZ?=
 =?us-ascii?Q?09mBIrSAyoK2i0q1MEpO7NXP/BD/RjkvWxLoHETq64mfkJgHC50XHl1qr06W?=
 =?us-ascii?Q?6wDEUT0ZV32LrEW9cdB/k6YuB1cxNdwX6zXdS/QNP9CBahvSBKkNIFDG9vNu?=
 =?us-ascii?Q?Q4ic249GNyI9Ss8o9yOfKG/WqU8AoNmcqdG1kQq5KDLBFhQzfbLHZ733K6SO?=
 =?us-ascii?Q?IyVkbRaGQZa90eMh0cH+f5dp8UEBENuYbm987dD7lhesdw6CsaeNJ4AfC9AT?=
 =?us-ascii?Q?+zInWKsJAZ+cEteLhEpQJ9NK4Au7d1eBTOruFN3u/zaCYvRaUXP4zjAyPqGH?=
 =?us-ascii?Q?EI8erkUZ0cKTY9iL/1+0NqF65tiQSBj8s/oOgONF0X+mwmkg/286UAuF0Wrk?=
 =?us-ascii?Q?9nV+1DMjJ5n38Atp4IxZSk16WYnXXmleDtoxUwkkxy+Qc99fwJKzNAZj5eCM?=
 =?us-ascii?Q?web0QUoF65VlxNZKs7E9yEphQZzxliMnKhrdKSi5gWQGGM441ZqyRl4NFtzZ?=
 =?us-ascii?Q?KDv08sklcQD1XrlDwXA/cjPmXHbnECTQEO/VD6ZhsvzmGIPsO3P+Lv3pjMPS?=
 =?us-ascii?Q?l2rQO7SAZXj+VyIIeYnYH8dv6UX/TZPPIlLwObRduN3oLPmvMOmbHO8TNtj9?=
 =?us-ascii?Q?eiGotMUjAq2JfIgvTDTe0rCCLXyx6Jd+C0MwIc2UNOmcS0nFoIZ09N/Ulb49?=
 =?us-ascii?Q?7g8/cA1pv0c2vUtKqv0xYza9aE6BU1/Uvk1bBXZKpO0J9zUHNWKd3l6xK709?=
 =?us-ascii?Q?pnHZc6ieyk0bMo3mWZWQWYBK2e7YuQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77C2C5D1F578964790FC8A5174437B8C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41190191-7918-465c-9204-08d8c7b3377e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 19:46:21.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBWuq48wzYU4h1qY0TnK0Bpf4zdLr2GW3peZPGI2a8FaRB2DlKoWGmAz4WoBBO6iuLWDuASw3MB3a78VVsozTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2648
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020126
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2021, at 2:24 PM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
>> You're welcome! I'll try to remember to CC him on future versions
>> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>>>=20
>>> I want to ensure Dan is aware of this work. Thanks for posting, Anna!
>=20
> Thanks Anna and Chuck. I'm accessing and monitoring the mailing list via
> NNTP and I'm also on #linux-nfs for chatting (da-x).
>=20
> I see srcaddr was already discussed, so the patches I'm planning to send
> next will be based on the latest version of your patchset and concern
> multipath.
>=20
> What I'm going for is the following:
>=20
> - Expose transports that are reachable from xprtmultipath. Each in its
>  own sub-directory, with an interface and status representation similar
>  to the top directory.
> - A way to add/remove transports.
> - Inspiration for coding this is various other things in the kernel that
>  use configfs, perhaps it can be used here too.
>=20
> Also, what do you think would be a straightforward way for a userspace
> program to find what sunrpc client id serves a mountpoint? If we add an
> ioctl for the mountdir AFAIK it would be the first one that the NFS
> client supports, so I wonder if there's a better interface that can work
> for that.

Has the new mount API been merged? That provides a way to open
a mountpoint and get a file descriptor for it, and then write
commands to it.


--
Chuck Lever




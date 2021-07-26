Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C608A3D660B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhGZRMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 13:12:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11614 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229680AbhGZRMj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 13:12:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHpoER015530;
        Mon, 26 Jul 2021 17:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C+/rYDB8GNt2W1yiY9lVc9jAgAtqHxXPvpXr/grQD6Y=;
 b=K1qwprFcE29beVk1mpbdqrvDphHLc8+4cDlWY6Wxayi7O1KV5i2pNIyToZvKYcu92ii6
 /dwjxsgsCT2OqHPvbIxO/1LF2k3UHO5w5fvmPWyw/U4WAO+E3HmVNrAhCc0we0soUjkM
 rRnfJbaPQbCAllZ1mGRDoKyFks6K/6UePUTvxjLcrRmg2iyli5GRqn1AdBUnPbT3jrQS
 eTJ6m1sVP5dkSlC6DDhG0VmrrQwPYGgkSCSpqFUOiLKcjFr03PVJ7b9MFSzouNYJEImS
 hwW+n24K4l7+qRTvR2gCfGwaLG1lnt0gBGp4yhF6pthO7lK8tXT0c0EsZ9GzdMmqRQUT tA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=C+/rYDB8GNt2W1yiY9lVc9jAgAtqHxXPvpXr/grQD6Y=;
 b=G7/vAASwtnhBkzlfdU6K+470UbVMUj9SHvfCAQsPE9Bv2KJ0mFSBiwaMoBP1oPHfV9YG
 gH58w11r+yLvlR7wSn4t4YWEOvMr6rt/SUZVmUPoiolDXX4qc4at3X7QDUqOY66fEFJQ
 P6mQnjU5Ha/Xt5HyO3RYJUuGG/7iJ0JW2y8sF75/MyZrCVZqPfB0ma38MZ3iHnqBxzxQ
 1qDKEexM9UQpRws+rmTglXZvXLJXHsjBVjTtO4QKjVmHH+bkVbGvOjp4/vzisv1CTKC7
 PQOzqAFfPg6crUWnLRqPK5HXpI9dyAwT+1T1vSkV8iN6z8E7cZGrsB2qnZ55LCCeBXmD cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1ktv1wxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:53:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHoqDL066855;
        Mon, 26 Jul 2021 17:53:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 3a07yvy304-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arh9W+PgWyfYPpTJauvN73tP0ZRfWwAJe7ZGJjLXoDenuVy/NDKeMBVKuPQSptLu9GVmADYWfTDKLIo6QNDXlRAdx/syf+vl9euCNf7grIShsfZr+4K741xUKqVvyVB75xeJYIvD3x6TKeRT2B1quh3hb17LGYB2s4iuwqdFKMGmZ5V+4YH4so3aHJXA4PB6kKPQZu4WMzObTothHyEF8eg2oLF6nZkLKWMcr675YC63npHnweUxMP4djbhfIeZVkAwBebRUXII8shLMPvMuZaBrLGF+IbCEhNMNJQ17FjSyNBgvEUs72RC3Q26J3fa/JvDtqlYgNN2uqW0WAiI2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+/rYDB8GNt2W1yiY9lVc9jAgAtqHxXPvpXr/grQD6Y=;
 b=hIdQ38E+dglaGi/cnrg+xgvK/0cd5kQcPueAh4yzbPukFPAXPBynymiNuo0McYWyWFEnlO+wedMk55IQLtBqGqrAmoCquNX7dUAE0vscdV38z6zp1Yjo0A5YVjLn8MST8/ZH+S6RujP0henMrOI8PeN54QZ0pljlYOvMuWenp2Y+TYAolgpcQP0Mml8SegvJKXXRn/17wf9qD7FQSH+edIzhSrJo7Yr/F1rYqpmAydcWrQeo9Uqnk6SEMev4IVxQl+WeDFydlYqCaTmvH+GaKdtLvvnKkOKfeCuoeOfbMDKpxFZMx6K4igg5osNE0K/aWEEwFxVNhBENO0FZgpal+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+/rYDB8GNt2W1yiY9lVc9jAgAtqHxXPvpXr/grQD6Y=;
 b=XUaUKD1zT8Q1ttDWaUpIpco/WXQzGqoqW7DYgy8fxkde5wjNn+GpKlsvbxchtfy9AhcEVY7yeeYJvge/vU0CreKvhqWpIIcl/jqH4kxj/5XDIOVbyKHoXhS7/15dUBLe/0EJrENT+1acb/HEGeyFMB23972l6ZS+WqOs1sNA+PM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5534.namprd10.prod.outlook.com (2603:10b6:a03:3fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Mon, 26 Jul
 2021 17:53:03 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:53:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] svcrdma: Fewer calls to wake_up() in Send
 completion handler
Thread-Topic: [PATCH v1 1/3] svcrdma: Fewer calls to wake_up() in Send
 completion handler
Thread-Index: AQHXgi0aAICH5QRXb0W5AeOWKdTjH6tVeDMAgAARmgA=
Date:   Mon, 26 Jul 2021 17:53:03 +0000
Message-ID: <C5D8AD9E-8DB6-4018-A0FA-92C9A73B07AF@oracle.com>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
 <162731081843.13580.15415936872318036839.stgit@klimt.1015granger.net>
 <e25bd7be-6bcc-cf7d-efcf-1ac39d411431@talpey.com>
In-Reply-To: <e25bd7be-6bcc-cf7d-efcf-1ac39d411431@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8e02e1-02ef-4e7b-4ce6-08d9505e3728
x-ms-traffictypediagnostic: SJ0PR10MB5534:
x-microsoft-antispam-prvs: <SJ0PR10MB5534F3331714F25DD09BB37093E89@SJ0PR10MB5534.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txA6lQTVmsE4uaIRVCEt0Zw7xqZmbJPHS+LaKks/VpS5vSBRHwd7MsNd5foMZ4ki0VKSFJpCnqAsD1pxsNLmWsiWZLEd++WceZuvANQYRSsct+sMz7ypvbO4CwfDCSCzKs8Gaa4mIxPHHtJUiz4xj6Iy1p6egREOc6HOqx70iWiovPhFIxePbz6YUxfU1Fe0B+K3ddJLAdJUsSWkNZX4ODt7UizR/OGf4KTt2amZBKHYy5MZN5LEaaVIkU7VnHjb5lCaRDfC+qGEGPHcRPxsUtYa9CL87NKdxoF14iBxKbBKpvMBKmH/TDmVA0M1LrxWR7SdczXtkEVuWNGjVdyLKkEzTd+2jPB7vDVaAaes2M9tm26V56utfHzReP+6Q7lx6EM3Z5RtYm0OJ+kOykGxPSaJm1vQIVe9QREKEeAs1Q0e60KRelp0ZAtD490Yu113OiBPC50ISxTyH7fKCB1kmC0nMvZW7RvBsDrKiDrz0RcS1OgR5ywqmjUSnpFs2+vwItNWn2gGRITsKjW+CiYZQI6COfaeSGpgqqf98W6qZsnIVTZ8boCvKla/EB7drfoWIyZzfBJ3kLi3KhB5SQBFSrLjaFlM53CDE6hpbW4z/e055oUIX1PwkkgEmL0HKvKyhE5RYf8cmdpWKZJRw+zPZ4GXn6aQJcgF27d0DunHA8+sj+/WtAZyQ9Yshdt/W7tP8pwFOYaF3fj/qg99+1xvC6ta9A1ovKCv9a7vhEPub4FUlMxyVqRSvR+fCI/zDtTcX7ghVH5Gfq050haekwrPbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(71200400001)(6486002)(316002)(4326008)(5660300002)(54906003)(86362001)(53546011)(8936002)(8676002)(33656002)(83380400001)(4744005)(6512007)(6506007)(66476007)(36756003)(186003)(26005)(2906002)(76116006)(91956017)(66446008)(66556008)(122000001)(6916009)(2616005)(66946007)(38100700002)(478600001)(64756008)(87944003)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V87F+x7zxQSaT3D3tjuV6ZUsV3meen0lkIz+I5Z1DgXr8IcYMJMCFxi1eiz+?=
 =?us-ascii?Q?cdg5jAdr3o22uxI0450UkeU8widyyTIdoPWfw1Y6IJTYBo6vXS03rGoROV/b?=
 =?us-ascii?Q?zvkQTZpV91DG/ZUrY2rj8iJOHVcDWahq34/U3Xy27kp8W8ABenamp+AjTI5d?=
 =?us-ascii?Q?xSYPKZBbX7Ko/XRI2voeYGJVeY0LUo3Zjr4h3O1lqYCi94dNLzOo6wx+V0PP?=
 =?us-ascii?Q?tvzsZllv6swr3Ifs0YdV2q/QOSlBiu1HHCuYoGEfjZsxd+RQk0SOZ8T+pV65?=
 =?us-ascii?Q?+95lhSmwBevjXFG9gFyLRix0WoOiGpGaycXZ1wZridBofCAmA0Da+v38sAt9?=
 =?us-ascii?Q?2SRzE38oPhtxITz1NZDfGwSVJHjGuymXx0YZOfL8HjmsGFTAlMeiPrFz7tBO?=
 =?us-ascii?Q?YIybXznDCD/G77KH8Syx2Q6DnxF33NQN6aPuPq85f8Sgp+E8NyvqRCXf5Rry?=
 =?us-ascii?Q?+HRrQY9tIqGEnWa1EVXkNSsD+k87tzDsk1l/6v1XBB4tsa4XUZvdpnbL80xE?=
 =?us-ascii?Q?16OmGyLACSonExhKkTCPmLVdVIhW19s24xybCDgt3KOGb6ab0g/iX4kjKv5Y?=
 =?us-ascii?Q?uuzahZPmyGnbmK2FeJNvxGkWUZwQvwjSbHjwzAFAtF0tIAuiCC0vL4651wlR?=
 =?us-ascii?Q?j+NHTzu0aWt/ZL5yPknxVnICgl+hVFqWMTl+yXamY2S8kmZta0oILNyFcYoc?=
 =?us-ascii?Q?3l5f8D6kYjKjjycyLfLi4Yx0zhRIb1pUZD03Xh+0p2D73Co5L3wtPh2io2N4?=
 =?us-ascii?Q?0jFVzIj0IZgu2QrJZ3tWQTX684ArwcAAfyjpbwqiktS4i8x6640W9mKoggN8?=
 =?us-ascii?Q?3o42Z/VtD7RnOMhCDilstImzd0R76lL5rFoAFI9/6zs+z7zDMQttf9jRHikK?=
 =?us-ascii?Q?0c1CdXh0Sm8ChckJSN49fC0YyLN4C6USB0ftq5Uo3NVC/68KvoFdeQdJNqzB?=
 =?us-ascii?Q?l55beUYuINFYnoAj3p3vBz/uuPVqMOctxRW5N9gyf8Qw0tCbAcZ6WcvorZTo?=
 =?us-ascii?Q?1cWGsm/Np2v9nuj2n8RSqPfQPukw1abxbJEbtAT+uP7rxpiCkzCFOqsenrop?=
 =?us-ascii?Q?+sOa4dskmKiXy4kIXrDWTAd0g7OFVJqNQoqacnBECf6Xt8BvjiVd6DXQMsqq?=
 =?us-ascii?Q?8PzPqLMeY4sNdm7RypFNGzZ8E5hdZOQ/Av+GgrdG+KRG5ML/9Pb1h/gI2R1L?=
 =?us-ascii?Q?jXDivq8uBM/cQrEbNGfAwYLQHEb8RxGdRl11EaR5f9NGt4HSKL2AtegpWN2t?=
 =?us-ascii?Q?BD3K8ar475ROtb70SCPz2FyIW65l86Wuxk0CaCwlEvPnAV/v8+3ZODCDPXQq?=
 =?us-ascii?Q?EhHOSn+e6ySkqgjqVziIyxEnD3U7pUVhZ17Ysg9v+nOKxA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9629B880D53FA4D88FA0F008FED5B21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8e02e1-02ef-4e7b-4ce6-08d9505e3728
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 17:53:03.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAqA/i5jaZKwfnLb1+YtpVbW+e6tjO6vExibprptIlLdjlsY66FajAuFZNL2CU72GsH4VKJtKgisRda5lavTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5534
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260104
X-Proofpoint-ORIG-GUID: 1c0stp2ZQDC9cLbk6riE4W2VxTgDG9SD
X-Proofpoint-GUID: 1c0stp2ZQDC9cLbk6riE4W2VxTgDG9SD
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2021, at 12:50 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 7/26/2021 10:46 AM, Chuck Lever wrote:
>>  /**
>>   * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
>>   * @cq: Completion Queue context
>> @@ -275,11 +289,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, stru=
ct ib_wc *wc)
>>    	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
>>  +	svc_rdma_wake_send_waiters(rdma, 1);
>>  	complete(&ctxt->sc_done);
>>  -	atomic_inc(&rdma->sc_sq_avail);
>> -	wake_up(&rdma->sc_send_wait);
>=20
> This appears to change the order of wake_up() vs complete().
> Is that intentional?

IIRC I reversed the order here to be consistent with the other
Send completion handlers.


> Is there any possibility of a false
> scheduler activation, later leading to a second wakeup or poll?

The two "wake-ups" here are not related to each other, and RPC
Replies are transmitted already so this shouldn't have a direct
impact on server latency. But I might not understand your
question.


--
Chuck Lever




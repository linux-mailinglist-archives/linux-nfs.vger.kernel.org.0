Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E791332D7A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCIRmv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 12:42:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56906 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhCIRmX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 12:42:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129HPmsX073557;
        Tue, 9 Mar 2021 17:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zEpZ/qr2rM+WpPrqqVBCckct6www/LCHp9Ehj8SGF7M=;
 b=ibLdrADcDZIwZ/rEx47PUmiOZVEKezPsTk464KFshGt3noH+1b5snscsiwybcMSljBbF
 I8dg1LJVHb3YEj1yMRirZQDSRYGtcWxV8YPRQ98Uxh2KsLnJcKKtSmUNzM7Gn5owQOM9
 +sTgxQmRqABvbBSFGZo/35oIoQF46N9Qh0VQd4jfjxZ/VeA/B+BQwB5K+HULKZWMjMXy
 niO08fSzTUsfasAsTBQREo0udxF0OoHwZW8okAt3H3szAKo/2n6rsKxXOuojwauc7+Hc
 pM4IV562Raz1WqjL1mr2h+Q1IBcRSnIDrtcgRbnDSdQQ8U6ykflJ4CYIaY5tyAp9p8s1 sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3742cn87hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 17:42:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129HPPVb006888;
        Tue, 9 Mar 2021 17:42:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 374kap1rhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 17:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuQVoaZn8IxTxwWsQVTs+0rZoDd1l2UQm3Snrc528R4n/Jvlf/iDQ3LY1bnmxzxDmYbDj50+DKObq7wv7Q1Pn1gsyaKn7jpdg99KQ7Bbjz2YC5EDXy5ZTkb2VqgG75Dy067jT+2IgrjezqV+zvy2FLuhQDG+pg65Fdcl41UzfkOS9NZ+s/vNx9s2gENLbfkg06Pk/2JUkP9vPiucltBud6acw+7yaXHwhy7tx15H43sjbjt1YgNR9HXHEC3Qb+IW/WK4iN7kr4UJBNbEtGUmAsqfy11jOEm0WPHXgTOk2kqIqUAnVxeLBMCtq8KhDPf7nLgEU65dtjzJpezwlSeEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEpZ/qr2rM+WpPrqqVBCckct6www/LCHp9Ehj8SGF7M=;
 b=Xkhxox8OjyX2Ue0QIXUhlpcXcOh6bjNs+X5ZJ5cxBCY1aUkTUhjz4nK6B8n+taD961NaM5R/aIn3WEvuM/Ie9akfaNdHTRX74fSsekmSKWR/C21YRpT2OHt8builCWhQs7QDJhpLOx6XkLN8l9R/Wm6iFc/wX/lNSxlFxc5wQwZsabdN/88qJ1g6EfKo+chma6TAq1E9y/lRJU+lcXqky7qGV4fJdEgxo2WBegvCyQq9t37x6aGFqQDgKxoZF94nDW3goov+4+3WWU+Zn7YMC9mxowb2bRX/mVIXG8zNSV508a1zb2ynAmj6B3K4g4Plxc9ADiddaXzlb5XTEKHL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEpZ/qr2rM+WpPrqqVBCckct6www/LCHp9Ehj8SGF7M=;
 b=kwWIY5gZzC0j9ic0HMi8QIFQYg6xy2lPkgjWMYyowXtoLkMUaL5dylAY6IgpD/fRdzRmcqK9PTG5/RCRwzNpYspCVx1YM95gROTOr6Q3RyanCNzNxRGa93kwAVuyZRZuAxYyLnlhtLNRBzJw0xwnu0+t7/vB0ZN9evU5mbXpnC4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 17:42:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 17:42:15 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Topic: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Index: AQHXFPJMATYPHlFtZkmEJfeeuT4DnKp7ykSAgAARegCAAAHdAIAAD5UA
Date:   Tue, 9 Mar 2021 17:42:15 +0000
Message-ID: <63CB3509-0EF2-40F9-88D0-F6AB8FC04DA5@oracle.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
 <CAN-5tyEFRiA2xcHBy63cgD+zAKDOR56A+Vo3te0zmdWVD72gDw@mail.gmail.com>
 <CAN-5tyHUWJR6MP-PHc6=26Rz1tO_LYtGmjmU2HFf3uyg4NMXsg@mail.gmail.com>
In-Reply-To: <CAN-5tyHUWJR6MP-PHc6=26Rz1tO_LYtGmjmU2HFf3uyg4NMXsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b049f90-e65c-453b-56ee-08d8e322adc1
x-ms-traffictypediagnostic: BY5PR10MB4161:
x-microsoft-antispam-prvs: <BY5PR10MB4161510A34542DC136E22BA793929@BY5PR10MB4161.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elq4EOUe1RFKFF5qIHr1qjj6wU2xg9eavIWCUOqKYphSk8uFFiPhk2AXItKMmskp4q+P692v4rQyMmw/w576TOttNTFoJlMYrViaTMMIHuEaHzajOfvXn4bDPrYzE2DQu6O52xTPFCKGGc2+swX3bNZvQGoeeomMDItxsAKQV15o9oYyYnBwF6qQ7PqCQD0Ck8G5x/1gtGP85JM+NVImjwD70m4DpYpvnnOsgDBegZ1s9qKo9PZoje/I8GLfEQsbekUiQCK1O934VZ/HtI9SRJHAlrraD1FEbNe4CySOP55KAyFl2xb6+nDHLtCgMJx1fNs67gjta/5iDOW0wH0TpBGiThvQbLyva1OMNjUYBZ/qmF4YMUwjZlSkv1hwn2/WeTKvcDqfSiKkZxMcqrys+C2gC0fgzixpHVlVRtjdihbPDpxjbwQ3cUniEdlmGTooRGqdGW338Ys+a6hPPThLg1eoPphvXrrPlohFsWgtsQM/H9P7mUZhO+jwV60gXCG2I8SCMapw+HDqwltE2ktmqY5TnPbTsFU+y5nWQ9bkXma/ooyulEwXAfkiVbEDUKITyhL9DsK4qU1pFSWE1gNpDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(8936002)(6486002)(478600001)(66946007)(2616005)(54906003)(6916009)(53546011)(5660300002)(44832011)(6506007)(8676002)(86362001)(6512007)(186003)(91956017)(4326008)(71200400001)(2906002)(76116006)(66556008)(64756008)(66446008)(26005)(33656002)(316002)(66476007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lsquPPmHRT1Ecw86gLXdH6btpKcGQNqNJ0iVYfQW6AjQuVqPhbyxsRfCmAJ3?=
 =?us-ascii?Q?aRogPCod5YOE2In7RNJSFYpaQLLS6FSC0YRAlkYRAWgbBevPIghVwjS5Ds7U?=
 =?us-ascii?Q?g/Jbq260rIqsIc6r/yqXgwFLHPwLarx93UxCii/864aMuj8djXEMvYxqknjf?=
 =?us-ascii?Q?SAQ3NWJqlIhdsJAkphUWSbf11RBoUDlaq7Fja1WYGHOyUrsKiB8adrjJEsVy?=
 =?us-ascii?Q?pTMV0BL1zGxh6Ybz6ZeEuZlcJCL6NAA96fIifThw0Ne4ItPufZfAYDd9qHWT?=
 =?us-ascii?Q?Q/9ftY5D7+zPcaIff5BTPf+tdP5Gr7NcLVj9ArgFMXdLRUGOz0Fsgk5QL126?=
 =?us-ascii?Q?ySzhmwqj+MIHqGQpz5+pDQ+BP6G2buM9fgcfC4m8YEGqSTBQpXkAOzFxjpNN?=
 =?us-ascii?Q?syLBSvfPSzg1cVAR9XlWcg7Js2E1KAays6uUxaywZDo3WGw6sApTJcQzfoIL?=
 =?us-ascii?Q?0QBX/K8Q4S6qO2lW0/xVJAmnFrKvDtcChBpo1MUGr95ZRH0i5cjRytEKtUV/?=
 =?us-ascii?Q?AfxoU3pJltOzik9jiN0jUk1snRBZvmM4wh6FaZFsjUTjJq8c7thB2WfVQJqD?=
 =?us-ascii?Q?7d5OvLpzJ4MH19skuO0D0hB5MtptdBlnavzJYOeusmXRIWhbqawsisu+UufP?=
 =?us-ascii?Q?fS0R2ImQRwQS62k27+ctpyf9AYf8fZ/z5BX7KSanXYGqLypOYai/eSxOTorf?=
 =?us-ascii?Q?vH0V9Rll/VLZJenn2UWyw9NIB/Wj5SjW4XWWOqDYtVz5g9qMr6fFUiKA6G8/?=
 =?us-ascii?Q?5tf6QyxguUS+Rrtx8+QOgEY8zEykpqgyanzY7241Ul33yHDst8P8FaV3LkqF?=
 =?us-ascii?Q?Plm0QpDdoGHlaw9GDVETjMioUVoZFSccyVSK3ti/q9u66i2lFUrP0vD1P59s?=
 =?us-ascii?Q?59+8HmwASIvURuJ3wg2VvsIIqfNqTupmHYFzyQ7TTfRAfx7coWkYF/2EH+ww?=
 =?us-ascii?Q?1agDFdbV1r1p3sL99vnk+5qEHYWkk1/Ae3Nr724cTwx49Xiuip+Y8FktQiax?=
 =?us-ascii?Q?n8gIQdK+ZvuYZx7+5OcuFubDeebBswu+OqOoat0+gE18cpsT+oAO9hRgKd8u?=
 =?us-ascii?Q?k1O4e505A++aCvHM0BzxiaFq2QTYYEk9V6vK79BjXpwyck6RWuHwPSVBh0Zr?=
 =?us-ascii?Q?Xl5gr1LVndn8ZDrNhGiFD9LpaNxNktR7FLGQhagykO+XeneaTDxUEcp1kaAt?=
 =?us-ascii?Q?KUHM2FG+bfuTAKIBpRPZ4CkjVX9U+fb5+TiR3sbLZFiGTu5F2dK4hcbBCpZH?=
 =?us-ascii?Q?1BvWSlv8pR4D2EltG9GrE6SiETH/Cdj1x9w+moo+Ui8WsoY0PWt2IOKULx8Q?=
 =?us-ascii?Q?ALgbzKN6/a7iojLomCkNY93A?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F288069B57A1A144A77743DB63A37CEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b049f90-e65c-453b-56ee-08d8e322adc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 17:42:15.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQsZl7YQfzoVbymnZrn78S14XU8kRHhXztDvCvAKPi86Z2EhkiGPnu7R9naPQmxZj0KCQsojNw4khHFdUAPflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090084
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2021, at 11:46 AM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> On Tue, Mar 9, 2021 at 11:39 AM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
>>=20
>> On Tue, Mar 9, 2021 at 10:37 AM J. Bruce Fields <bfields@redhat.com> wro=
te:
>>>=20
>>> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia wrote:
>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>=20
>>>> When the server tries to do a callback and a client fails it due to
>>>> authentication problems, we need the server to set callback down
>>>> flag in RENEW so that client can recover.
>>>=20
>>> I was looking at this.  It looks to me like this should really be just:
>>>=20
>>>        case 1:
>>>                if (task->tk_status)
>>>                        nfsd4_mark_cb_down(clp, task->tk_status);
>>>=20
>>> If tk_status showed an error, and the ->done method doesn't return 0 to
>>> tell us it something worth retrying, then the callback failed
>>> permanently, so we should mark the callback path down, regardless of th=
e
>>> exact error.
>>=20
>> Ok. v2 coming (will change the title to make it 4.0 callback)
>=20
> Sigh, I didn't change the wording of the commit and left the
> authentication problem which is not accurate enough for this patch (as
> say connection errors are also covered by this patch). Do you need me
> to change the wording of the commit and send v3?

Yes, please post a v3. Thanks.


>>> --b.
>>>=20
>>>>=20
>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>> ---
>>>> fs/nfsd/nfs4callback.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>> index 052be5bf9ef5..7325592b456e 100644
>>>> --- a/fs/nfsd/nfs4callback.c
>>>> +++ b/fs/nfsd/nfs4callback.c
>>>> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task,=
 void *calldata)
>>>>              switch (task->tk_status) {
>>>>              case -EIO:
>>>>              case -ETIMEDOUT:
>>>> +             case -EACCES:
>>>>                      nfsd4_mark_cb_down(clp, task->tk_status);
>>>>              }
>>>>              break;
>>>> --
>>>> 2.27.0

--
Chuck Lever




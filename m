Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6454337FD5A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEMSpM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 14:45:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53820 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhEMSpM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 14:45:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DIUocs194056;
        Thu, 13 May 2021 18:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3IMx85ytIja3J0Wp/35vwXdv9t3isRLIzSES9pP8t4c=;
 b=cXVU55lPvzZXMrZG6Rf10/azmwXRQI1v/rzjZhFSyTfC63DOzBSWoFSnsAllYlBJ8npY
 vEvazhORF191rZoRVsZVZhz/HQMvaEmY9954EjAm/WrirvmLgRu2PAJKwtvzK5b98kbZ
 TmQRxY5CPqsaCLvvRqgq/h+mOsUDBiPVn59USreUnjC/vwQGk0JYo5Qupks9qFj4bnZq
 q6tyIEXRzzFlxD2oOgoUbGpjfceqPcrK6En5EDUNLZOawT94J07OvmHDgeIVb02kaoaP
 IJQqODKrKOmTBGQYE4kWOyukz4Oq0C2/duQGlFQkaztKHCROXz/9cdlgMZ1BsvU45NZ8 aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38gpnejhhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 18:43:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DIU9U6159298;
        Thu, 13 May 2021 18:43:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 38gppgft6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 18:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7VsiddfJNlhaxLmwoaCbLm+4vkweDTzZe96RslJ59A1LoLlNAp0ecLmkqa05+H67LVpB6MlwKy+wUy/5WjJ6mPGPK+t5ZHFuZ09kACbD9gN1FeqsIerXJ1MHLI5abRroiP0zzLZOv18LcnJyPIHzRSJZ0TL/UpvDO/GO0qoiV11Et1C2GxASHhKkboHIIzctyK4lc0/KUbja+JOV51N+hypKuGgRXe50ot7ZMgjIOpbpuIBqS34MS5NvPr5ENHrtkVuYdo6EPSJbDtb5T7UJXOYSK7b2Md1wA32cigLja1LFqce3VP7sGvJiRDJuwsH0CoH3WprAUgF1qwn9trTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IMx85ytIja3J0Wp/35vwXdv9t3isRLIzSES9pP8t4c=;
 b=RQzpoEz+6eNC8X9UUxxnaAWWDPMnek6hm5uROGrUdijiqdYNjC5cqp9tAVqjULaL4YWXFjuNaaD9vlR7jQ9K0vPJ6Tdfo2aybafRbJ6+Z1LItWALt2nBdsKWwCJXFT5jJRC3cfpKNrigkjPwpxoxH650p8BO0TDC9znfYyMjDorVhubD8oJgE21KlTYP1g3+pjxUYCnS2G9EdX6W5t3CG3lOB1XoEXmknOgAjS2Muup6y7fE1pcWu08dgwLlKtVZmiE0yA8V8w0cUNxRH7iHQylBy+6oTGFmh6KaLglji6bwWC/8ilGc9rxke1sOX0URS97p7K3pEb2cY0iMQZHLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IMx85ytIja3J0Wp/35vwXdv9t3isRLIzSES9pP8t4c=;
 b=gfNH9iHmurpMhR4/mOYnrBGZtg6B10yExNncxy5KtAvbQ0awe0rbbMtD0DN+z2358zaCg45P6x+ieuNf+cwPs6K3P5wpamtsSwoHsi0+bUGlrZ5Qq7domLCQ6h1as2snM8G22nf9wCnAoIXe9aRiCBFnjF91pf/B4mKSOKK5DV4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 13 May
 2021 18:43:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 18:43:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAAAWZAIAAO4wA
Date:   Thu, 13 May 2021 18:43:29 +0000
Message-ID: <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
 <20210512122623.79ee0dda@gandalf.local.home>
 <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
 <20210513105018.7539996a@gandalf.local.home>
 <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
In-Reply-To: <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3f2710f-bde6-4984-6d6d-08d9163f0067
x-ms-traffictypediagnostic: SJ0PR10MB4605:
x-microsoft-antispam-prvs: <SJ0PR10MB4605F756CA6CC10071A00EF393519@SJ0PR10MB4605.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rn92TtCm2h5fwucKP2gaIpS8O+Z2Nmco4oKcL1W6uA7pqxeT/ZD4EFfiNCzDec1gIPwQmtgc47tX2TI8/OEprDMsHb/aeZUjdT5I12M8TuR0c33mCjb4D0QT1s89giveE8vAP1OR8+sAj0TYKrxBvBzHg8Ho05DOzfmS5roLSenAT+I6Ro+fqNc5wj1vU5aTm8GEYP7jP5fWQKLdkXMku9AS3eFV3utcUoZlp8C4WJLuWzV9gUzxjbmKA9uVNrTFobi9nd2gQTgno6ZpAVZr3ZEUFwfLFBnK0Xt0K3fwDoQecwACNsaRDmBYdQzoFd/quJvj0roNbaOutSwsprjl2IMDbNBgUFSiHNVMbm5EDlIoB1ntiByxZdETLVbp9yztrBz7WRibvckFSuRNfezA4l55XAoBwCRRRbzZ3k6Fox/A11kQ9xdN8vITLhEw5T/TKgF++9ZDu068HA2djK2YmpgLi6PV8Qw3d/h+bOpN8NUFoSevj2nktjqBVv7Evlqyhh8O3Ti199E7snf6LqyXhBKIRlXid9H3f190B2X6JAlc1+GA1Vid+KySkdXMoqfN3b5KvhsTRP3Z/Eil0B9ghre/Fl5yplMfur3JvpzCV81ZjRXYMEsaXNUeUSMpUJUBpHLhie8xgad7wEsdDDh0wvLPON2R1lgLG7injiiNt8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(54906003)(2616005)(5660300002)(4326008)(8936002)(6512007)(316002)(6916009)(71200400001)(66556008)(2906002)(478600001)(6506007)(38100700002)(53546011)(122000001)(8676002)(186003)(66446008)(64756008)(66476007)(6486002)(36756003)(66946007)(91956017)(33656002)(76116006)(86362001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+EGxSHlXxgzKmzfqLJfqRP5nr8LEFtbvjm6yZSJ9LTRzl7onjPJlcun/njgF?=
 =?us-ascii?Q?XmpL8RTxAP/Q2V5cltjodmlBG9andoNLnujDZzT4veGCxSYIn72X3Qe1cQS1?=
 =?us-ascii?Q?Rcp8wC5IcV/mBwWyN4LBT33hMtgK/GAjUwbVroq8fCA2dyE/3bqazZe7S7WM?=
 =?us-ascii?Q?rOlLrKO1NumM9HhaCCvIYLCZp9T000D1BQpT6aBfALTfrCNa+RLJyiGwSYBR?=
 =?us-ascii?Q?RA3dr1SzvR5bob023fUA6AvBi0yAGvgA2xBNnLLHnq+PVr4toTrlvSATxNSN?=
 =?us-ascii?Q?8Mq3NAhNAkIiiMSVmnJYVYJSpb8hHXbxQvBHXu4KLo5+mWqy9JFQsZ4OZ8fD?=
 =?us-ascii?Q?I7Q6MN4FrB56KUtWEBTRQH+dsQm+z8FfVoONIVep+xfLqIcRCWIZzO3izjRL?=
 =?us-ascii?Q?NoBYDrS5JLWQJBmo2cDs5dgCsfQCX/vc8yRsqnnkx3ZTccE67gggqAvFiFyl?=
 =?us-ascii?Q?R6p66lx/yvVF8Y7TvjpJZwoK2Yk4PjgWrZUscNpnuhRU8iNwWwN9qs2F8u5g?=
 =?us-ascii?Q?QdfHBXylKyPRU4dBwLK3Pze0o+TqrvESthkmnJWsK/yI7jtVCS7JB8AXfusc?=
 =?us-ascii?Q?kx4hA/1GolGaYc0/uP62Wfn7tCv8/6CbO27qfpS2p/MBTADRe8Qdiz6vSS/Z?=
 =?us-ascii?Q?8yFJcZ6ShbO1tHNV9PA2pAby11wUbG+wu6yEWVlfQbDsR1oLGzvHhDAh5PfR?=
 =?us-ascii?Q?2XQ16HTES3ycdntFvtBACYZpLPjNvITyPloTNHcO8gxNFgJ2SnAXfSI7v50w?=
 =?us-ascii?Q?1UTtU8wo8uPOKJKgt3w2MQuj/nK6f3/HGMmdle3qD3sRkAQxtGtMWv+8nuCd?=
 =?us-ascii?Q?dEMeKrx7z2ps+uI+k9qH9ObnnXP2QgKysiyOptpQ9YQ2rfOOIGwGc6DfD8B3?=
 =?us-ascii?Q?MR/5a536CjRX2PjqrhCP5jVGfKGFTql5S8Kbtq6we1gdq+ub6GhNG0zjq+JB?=
 =?us-ascii?Q?wsJlDdD1ByfNHvaLGzM8kF6YYMW78utASP7xaAIWozeOfVsuWnclQNWQwDVm?=
 =?us-ascii?Q?mmNj5LomlUZ8l9+g2yS7hoKlxSRVJ8HPdb+M9eEWX7Z6YyPC42Qjwim6Gu7A?=
 =?us-ascii?Q?79mSM9n840tBlVHI1T53LllRtSdNjk1N4UbVxrb5Bo6AnE6Pgeq6xcpGhKgU?=
 =?us-ascii?Q?Z3tfX5weHSg/6cAveLYvuVayGM0pEcO0eJk0jKnngYDs4fuoxPPVWLOv/gg9?=
 =?us-ascii?Q?UZHy3aPTbxfVTJ65Sv5oXsLz8N0EuB7UAJXkE51y6ScYhiXkTEvmsx73Chhw?=
 =?us-ascii?Q?xB+yCvs4r7Pe3GZeSap1OgdB7jevEcHLFz0RXvPyMvC4ud/3AZ5NHHfR/Ixy?=
 =?us-ascii?Q?V04VIsNjr6iy/20POBbeqYVr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13373811E6A18F4F9627F6945431E701@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f2710f-bde6-4984-6d6d-08d9163f0067
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 18:43:29.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mn/w42qwXK/iA/vn50tYQwB37AMrnWqftDdb5JMHTNQu9b9Gfd40a9R7/RlfPVr4y3vt29PCgHTFEwAvqKhgwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130129
X-Proofpoint-GUID: lgX7Mne7XADwtZVQWO1S9w-oBM5ZDnpG
X-Proofpoint-ORIG-GUID: lgX7Mne7XADwtZVQWO1S9w-oBM5ZDnpG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 13, 2021, at 11:10 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>> On May 13, 2021, at 10:50 AM, Steven Rostedt <rostedt@goodmis.org> wrote=
:
>>=20
>> On Wed, 12 May 2021 16:52:05 +0000
>> Chuck Lever III <chuck.lever@oracle.com> wrote:
>>=20
>>> The underlying need is to support non-NUL-terminated C strings.
>>>=20
>>> I assumed that since the commentary around 9a6944fee68e claims
>>> the proper way to trace C strings is to use __string and friends,
>>> and those do not support non-NUL-terminated strings, that such
>>> strings are really not first-class citizens. Thus I concluded
>>> that my use of '%.*s' was incorrect.
>>>=20
>>> Having some __string-style helpers that can deal with such
>>> strings would be valuable.
>>=20
>> I guess the best I can do is a strncpy version, that will add the '\0' i=
n
>> the ring buffer. That way we don't need to save the length as well (leng=
th
>> would need to be at least 4 bytes, where as '\0' is one).
>>=20
>> Something like this?
>>=20
>> I added "__string_len()" and "__assign_str_len()". You use them just lik=
e
>> __string() and __assign_str() but add a max length that you want to use
>> (although, it will always allocate "len" regardless if the string is
>> smaller). Then use __get_str() just like you use __string().
>>=20
>> Would something like that work?
>=20
> I will test later today and let you know in this thread.

All good.

Tested-by: Chuck Lever <chuck.lever@oracle.com>


--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C79379867
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEJUa5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 16:30:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhEJUa4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 16:30:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AKOKEP166439;
        Mon, 10 May 2021 20:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ug1ZvUHYlhpnS+oyD/p7xeOcmbhDdOaPzRvG9lerBcg=;
 b=b9a5Igc82ckfJ+V2p2WIsBzijzXin+d9mmt6KSmsqKvaNLG6tfjronwqvsQytzXxqtQ5
 q3NPzmle6mfMweeMnSV3i8HdRfkpE4GHg5qfwq1DV+vCdY9MpVUbicol0yKOfhxX4pe8
 rQuB7fUQ+Prnvi7TcY2umzLNjDt0eHinRLopNQPi2NLiPWEo5dpeatKaXsDOW6pyOiFc
 tWuvLr+9NUSY7coqnusxkNQKOKxiyGrrlB1XsomBPol+8GXQ0ctanJFqtYM34obsLLNs
 uGNhkr/veETQ5+2N5a/8GHRdYYVLhlDoGCJb3TCqTgpm6kOmDvikv3rmkTSl9isPbKwO 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38djkmck5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 20:29:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AKTl78110964;
        Mon, 10 May 2021 20:29:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 38e5pvxsc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 20:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrHVDsj3tE3EaEN9YHzlGfj1qHAvsw78I6DK58SZ73x6rwfRnQQoFljVQ3/4FyqGAuZ1IFjIt/2L3qQBqQselbRYkDNcoVLp8WTOKrH/+Z1w+pXJGQmiv7yeBjw8rUE6XvwSBcY5VKY1GTrWCYCtNpEGiC2tnb7qvJlg8dhrnrPzgvjxk1zeFIEaBCiJ4pU26bRZDi6iOyiFncNlXpDSDhgxEpW6AYs/PgR3boSs7kepWzDWzWrUcvByDmq3FM/HEh/WWW8xgcghCVbjGBxxqTgNzyUzFbzZUnrTw0sRTBDY6GKX4nVeWpU0jRdqXLaLqhIFHO6CzSSZsHUfUBcvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug1ZvUHYlhpnS+oyD/p7xeOcmbhDdOaPzRvG9lerBcg=;
 b=n3Ab766f+cO9CeSGaLgyaPg/NYgWKemeOeEUN2jibtpNPFcKCYPzXaovJK8HgrHY+JEhJvuVbPDMg3HyyNxPciRzH3gMbiHdwhnVeVvPepjL4RCqZcsxTucUK4fx7ijKCQOuNLWpMmLzJAxUkY5BMa+gH8/1Y5kA/Hjh+yB+Ds8a0abKYLVht/iDxCLsKFcDT07nMks7ixZHQBZnD1Yy1640nL2+UBzLnYCAy4hnlLKGcbtuiTMhdn4jHjObYaYcKL/VYCpJG/OIcHNHtCK2+misLPVn/oqZPSPAxKOX1Qtp57b2b2YGKOP4mkAPQhAY5+RCGlAAXREncjz4nffvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug1ZvUHYlhpnS+oyD/p7xeOcmbhDdOaPzRvG9lerBcg=;
 b=KXs4O31mkxtNQr8Y2T/0aG/oGznJEru7rX9/WZNCKgluSTDQTSep/WvRkLoNddaX8P3Qzgcidb7IZ4OV27aQN8Vjw0LRt3tH6i2n9zDOlzxA1AeB9hgDzP67scwd0TCP2T+xiEDV3PDSuz3wds8ucZhvj+gKM4AvN8epPRAIHXk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 20:29:33 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 20:29:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     David Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 06/21] NFSD: Remove spurious cb_setup_err tracepoint
Thread-Topic: [PATCH RFC 06/21] NFSD: Remove spurious cb_setup_err tracepoint
Thread-Index: AQHXRbR+jw8deaWN10q4PECm07TfIKrdKlaAgAAAnwA=
Date:   Mon, 10 May 2021 20:29:32 +0000
Message-ID: <42BBD4E8-7254-4ADB-98C5-84DE7AE1C9DC@oracle.com>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066193457.94415.10829735588517134118.stgit@klimt.1015granger.net>
 <20210510202719.GB11188@fieldses.org>
In-Reply-To: <20210510202719.GB11188@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 599dc4cd-b703-417a-96e3-08d913f2521b
x-ms-traffictypediagnostic: BY5PR10MB4162:
x-microsoft-antispam-prvs: <BY5PR10MB4162A324B4FD1D05A9729D5293549@BY5PR10MB4162.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CbU98UWP7TNobjQtMSITSxWDyQb166tuKXwCwUE67VCGfi8UlTa8Fp1OJ2SN5XkrfOVzEj5/t/n3ehxws8lHZHx0dfbxgYsxyN9UaAYixGev+Xf+i7LSIR6v4VkCkK1axd7jimoDmDZKjgqBYes0k2GPbUMX4/c7lX0tf4TcRIZYzadVTrnU160OPOPz+ELSeKrKKotEkr6loczR56hnhTWpLm2+P3xHWUq6yG827qCf9OpdIXtEJ+nZCkXq4yPWC4cH4fT5W0y/FaCmoI0+RYx6U+UKswKidTZAo0VcehF5KqLBz6VTFY8zTxL1xxItv5DCNWkmGRKRXBlhZ8MpBt2F7ApAv92ZFYHU1JKxIsK8slIPzNcDujB/+l8EZ2T1pPA62y6iQ8v/Mp0ZsdFANiPfq5BTR7BLtEC0mPqg2ZLS/+r9MgSSGwosIWm7W/+iSAnYuy8dO8Pxee/zzylIeckfZLua1sJQhTHOdyyUjTTb9O/k5/xkCeNiYgV387vISRsC4n/RK29Zg7bknQV4wcgnULYdiKT7cPGPB5KNMxghLmzYD60VzbUzgfmbmpAYRd3ttYTx0Zeaugkvh7cHb6NwSahqrsxdkR0Iln+MhF69ru0Cb5WLBzxi8Rgxn8odgmkXaH5NV6dD7DxDTcPutoSLXqPnpQR4VZuWOhXz40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(6506007)(53546011)(2616005)(26005)(54906003)(316002)(83380400001)(186003)(2906002)(4326008)(478600001)(36756003)(71200400001)(8676002)(8936002)(6916009)(6486002)(6512007)(5660300002)(86362001)(66946007)(122000001)(33656002)(91956017)(38100700002)(76116006)(66476007)(66556008)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uzg8DeOxuvtE+GtggVGK6UtsI7hu1BRB88J39eDbH+AKsjjJ8z871N5MuI7t?=
 =?us-ascii?Q?9zfXLMxPbNkNfTmv0E0zOTmBYM08KqdPtWaiAww2+CI4PxccpGVidvSKnWib?=
 =?us-ascii?Q?YtOZ0x5dAia+uhqIcPaRPuirzSWrLwOPrtwRGorPgAnBUvLndnThNWwBjE/J?=
 =?us-ascii?Q?aVv++nbNZ+m7dUemX7rtVqsmZCmwW8hLysOPACfSUxjb+/qL3tvcP3Jfgj8f?=
 =?us-ascii?Q?ECWYhTlIJei8Tq0VmkXfWWA19HlVAjCPdcWsazA/1h+jg6u7WAgJOjM5nAxA?=
 =?us-ascii?Q?ix2/HPOZSThJ/fMEEDLCc9ai/Mdsmi27JQv5zmw8R/xcUXkp6mCE9pMaWgy+?=
 =?us-ascii?Q?zsloAdqmAZP86knFcoLxTyqSvloSMpX66p7Plmb5A52HcYQhbLaZSL32UZva?=
 =?us-ascii?Q?c0pJKAzFTrTx/eibVaJUSMZDfIi2fqYIMZWd9dWk5vmPFrDONWuz6d0kxOOj?=
 =?us-ascii?Q?TZkr3EKVb7thS4T1UZB3SOGZmGbtC7/cOVMoIdlozTRdF4nvBYG0cK9eTjt8?=
 =?us-ascii?Q?IauzSf05YsrgEj1hPDcvNM8Jdx+zAu9jkT9+g9hZw8Njl6GCLSSQraQbEdF0?=
 =?us-ascii?Q?g8c2nQn0fr6VA8PbmtMA+2SVw8MAZaZFHKCrcHzqKH8EizrxuGz2Lh5jg3uy?=
 =?us-ascii?Q?n+OW/RLNFLh2ynK7YoSeQNF3rZsZ5DoRET1Q8KPDbnRMx5qZuwvYAnEGyR6S?=
 =?us-ascii?Q?AOJzQvQL3X/loydOvTYIDAihq4uImBDXDb1BxRpVFdGr8s6NVP9aFU19bR3a?=
 =?us-ascii?Q?Xv1pfZq3PwuhuJhma3WC6H9MtckG8lgZPLvSJxcbqpxq53tGhAPX67doTmlj?=
 =?us-ascii?Q?cpJ0jF/GXMqgQqyj2gvR0wF0xKy/u3p6YBtRaLFq98fvPSFWQq+OWAJg1AiM?=
 =?us-ascii?Q?Gz5pBxWkKHvnHJbwLoRrb8tKnWjV/IZzMoH1+7SVpObdDWAdV/o65rNcB5RV?=
 =?us-ascii?Q?T2rv1p5BFIbvQyv9UIPuYb/TQlaP+GqDwM9jSvXJYlkghz3YjqqI5kwQxqNL?=
 =?us-ascii?Q?/kHyVrBfK3pG1y0URdF2LQafCjLeYjKGjqQmfcRVynCovjgmYJ43/b5/LyL5?=
 =?us-ascii?Q?ZRQP4G+iBcJKW1TTHXOeOKfZJtF81NLYVTca3EhukezkJXCsK+fZJJBs3gxM?=
 =?us-ascii?Q?CHaBwJonvVBkTXUsu7QWdlU8852pAEL9IcMzdJvlIweCVXq1t86KSFriLcvq?=
 =?us-ascii?Q?+wjQHUe4lCoHgPDuwAObXWCh5jz2aR+yAal5rrA8jvn36aaPin3/eCVgWiQc?=
 =?us-ascii?Q?WoB4kp2vqcdXcbTwZt4LeFBsnKKg5Lg5m9n0PibV+ErAkcr81ETeLpgqYqle?=
 =?us-ascii?Q?lwzUG8vJ/2ItnfW8WN0nd3XU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D248FF2129317247AB48B465EF12BA63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599dc4cd-b703-417a-96e3-08d913f2521b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 20:29:32.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WE+yRfLv0nfzzVtxG6Bktl91fI5ozv941BKaGKhUQZd9HWBBrf/kIvGMpG+PJVBIqxfQ8OfeP0XOeqggPKINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100140
X-Proofpoint-GUID: WrnMSQkuE18l-906pm3B_-2p_1Zdrcrw
X-Proofpoint-ORIG-GUID: WrnMSQkuE18l-906pm3B_-2p_1Zdrcrw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2021, at 4:27 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Mon, May 10, 2021 at 11:52:14AM -0400, Chuck Lever wrote:
>> This path is not really an error path,
>=20
> What's the non-error case for this path?

From what I can tell, it appears to be the default exit for when
there is a session and backchannel. Feel free to straighten me
out, but it just seemed to always fire for NFSv4.1 mounts.


> On a quick look it seems like that'd mean a 4.1 client doesn't have a
> connection available for the backchannel, which sounds bad.
>=20
> But I'm probably overlooking something....
>=20
> --b.
>=20
>> so the tracepoint I added
>> there is just noise.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4callback.c |    4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index ab1836381e22..15ba16c54793 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -915,10 +915,8 @@ static int setup_callback_client(struct nfs4_client=
 *clp, struct nfs4_cb_conn *c
>> 		args.authflavor =3D clp->cl_cred.cr_flavor;
>> 		clp->cl_cb_ident =3D conn->cb_ident;
>> 	} else {
>> -		if (!conn->cb_xprt) {
>> -			trace_nfsd_cb_setup_err(clp, -EINVAL);
>> +		if (!conn->cb_xprt)
>> 			return -EINVAL;
>> -		}
>> 		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
>> 		clp->cl_cb_session =3D ses;
>> 		args.bc_xprt =3D conn->cb_xprt;
>>=20

--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1D32649E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBZPWJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 10:22:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZPWI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 10:22:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFFUIG109612;
        Fri, 26 Feb 2021 15:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wLBhiFhQ0VwbO1ldjBv1xwgNi3iDpAELFpGy+e17vXk=;
 b=PxBYjcygLLvC4Eafir2dK1dW8ug3TQs4aIIllsglBuOtW3yqNx8yfYLrhR2hJYejhSVq
 aZGoizvEXVgepurHeZwTXsxpC4/kq9KStWhI/u+lv21SOVJ9imUINCqhPXVx5Xe55s0H
 POfTcj//+E9fWbM3uIiAN+OEBU8LV9eK/gPRSDrWCuZEpyicnmc1cStnxWsT70UwjWXS
 OtSH4Qeh3ydba7qVIzYVAnrLYhhfi+YMafCZHNEosTShyyu9WGIH/h5rzvi0fwuGGNuL
 3o2VD+n8bJNLB0NgOMvIU6SVaKCRlck9YXkoxFap/almKGlXWkVExIF1N+3sjLBnaBnz ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsuraa8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 15:21:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFAJAw087188;
        Fri, 26 Feb 2021 15:21:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 36uc6w0q6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 15:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7lWUuxFXxKkCACK6R6/w0Sm1nmTUJ0Jf6VjqDXa4bYb7FfDY9RTvOhnWwvxeIhL7mgy9+YaXTgo1AWyVmGBU9Pcg7zb8upJ+f7nL5SiAi9qqK5i6tsbm9RNwpdrSvTrVWvjdgZOFR0Zs0oAVkunbEVUHSLE2ZN+BvY2c8vm/BBtiXv9bypP53V8WXTRXbyLNrj9fj/jF0s+ADislxte5cDs9j4L3k9jWQ6xpIqCUBlxO8vLoizmoTWvJ5BjASeGOieYc2p3QMRBoy+/RnZKlSuBYk3xtELBNtsscofeiSR5NJeOvuU4pon5wKv4YCLqsXcurnJWU4V6P51CtifPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLBhiFhQ0VwbO1ldjBv1xwgNi3iDpAELFpGy+e17vXk=;
 b=dsz4Udn9CutG1A9P+Y1asnNFxKrvLnxpNZHQg4h/BPswHdCqlKyH+m1ridTqyteqjal0ITtjWHVX3vfZ/V7zgX0bwdOqCy1eClwEawLGcnu31mDuDlqKYTooPu2rI2e2VvFLnU/6jdYC54ccS1ZvQyzhRRTLlZi+fGT423B3BiPgl25OO0CWccQ3zFqMx4qMCaOlCuRibndiinEKbxZGm8T9r69DHk+f3YlfUv1FyqdZCqHyYQJsnFpUx+Bm1L1URabAuomULacMjKNQCgug4SdqjA2jonrq7Y5/WhXIDsTetAcWSe31qBcf9MkZbOuhTD6v8kCc7i69mvdRzAdl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLBhiFhQ0VwbO1ldjBv1xwgNi3iDpAELFpGy+e17vXk=;
 b=ncSBg6hdjz43gNQ28uy0k0UQRBkijoMMqrrPuBY4CGwRxvPhZ3LhazItbxTNVMN7i6TnfwwEJyTHnHObWmx/t6aQt6grEgoRmKrqqmIliphx7PTBUXwEnkifaqYMSsxaYA88N34xWLJW0YBPEqpRdqdnlg5BCgPYt0+Moi8oMz4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 15:21:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 15:21:14 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Bruce Fields <bfields@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Thread-Topic: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Thread-Index: AQHXDFArNpUDpBnnO0SmlDmeu86JQ6pqi+GAgAAA+4CAAACOAA==
Date:   Fri, 26 Feb 2021 15:21:14 +0000
Message-ID: <F5D1AE65-5AAF-4FF9-90A1-B771005E0756@oracle.com>
References: <20210226143820.GA49043@zipoli.concurrent-rt.com>
 <YDkNFKmzb7rbumYf@pick.fieldses.org>
 <AA751435-2DB2-467F-B0EC-133BE62A8581@oracle.com>
 <20210226151915.GA2586@zipoli.concurrent-rt.com>
In-Reply-To: <20210226151915.GA2586@zipoli.concurrent-rt.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: concurrent-rt.com; dkim=none (message not signed)
 header.d=none;concurrent-rt.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc60ac6-ac9a-4db9-4e2e-08d8da6a2841
x-ms-traffictypediagnostic: SJ0PR10MB4688:
x-microsoft-antispam-prvs: <SJ0PR10MB468893C98197D69C5C761F83939D9@SJ0PR10MB4688.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVbbN/H5tf673rTwPMBtK1oZ0+oD8G4jOsPHZsPCMG78XqaGhIngJM/ve3IxV2d2W5p68xwoTzTRuehk1eY41/Va8GQJe10FJbFAhE0GJkzZjIvU2xN1oS1UeHqdeiFU35737fuiyFC39AdudUERo3m8sw6r/ajhgvQKDDdbVjsU6XHWa1TMqBz4i3kU3wWwktn/5h8yVot7f6Pgi6atq8SQUMNRFfLK1nPL6+wKSUA54mL/It4n/+/jIzvTbIfNeh2ZPWkKswUgxzkxpQK0jbUkRDHrLizlBaHZMsHhXkB58AOC2Sm+08PStiA65uR7d/QfAzxhG5Xldjnbm+cgWbBO6Xw1D7MpI1kxf+eBYU+FCMgTYOdM93KI+fJuIhr9lW2vPJHMG/bCLRdN7mgffT8+v63M58IAg5sWRZD2iEUJ5JvZ61a/YzAwjVtNx4iIHLKJEj8qF/yIh04k0CKJCIdOQR80MMK8oNLXZcCxpWRMqsHrnZKSHiyUwkxYMm/z8TalSqS3njlQfkvzWdCsuD7eMkbJbh1W0jccEjikvnfqfeCjRTFjgZQ/RlV5Q7Dg39/YAKL+JGyA19SCeFGZbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(346002)(39860400002)(64756008)(26005)(66476007)(2906002)(66556008)(71200400001)(66446008)(33656002)(76116006)(4744005)(6506007)(83380400001)(8676002)(186003)(4326008)(6486002)(53546011)(8936002)(2616005)(6916009)(66946007)(478600001)(44832011)(54906003)(36756003)(5660300002)(86362001)(316002)(6512007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PlfQQWY0EOq+mUDDEaFAj4QZ4ncKufRjHmNHxcwS184jAlQirf7KJC4on4aj?=
 =?us-ascii?Q?NotMrA/czaJaiMceYwIzVwXNY1pxT0eaAo1Pq1HxGlDAtdySzS8HQJRvhAN6?=
 =?us-ascii?Q?GmIVcHRnwy65HVDBR4hOmfomAS4Wak1V1qmK2xi9ir8waIGXTUN15pbTBcXn?=
 =?us-ascii?Q?XXUwmeoqhYq3OTpFLBjnHSNq0q4d/rZGzwTb1pyTyXj+O7IGAmDefK83iBoU?=
 =?us-ascii?Q?73CSTvLaDOC/v21qh8z9ro5EMr6+uuWLZR4Ldy/hm2YysEVGOW43URnCNXwh?=
 =?us-ascii?Q?6uV6O8xYkAjRNbKjBmanQBAemJdxNDXnLybmoqpS+bpD3LEGMeb90O3W94di?=
 =?us-ascii?Q?3GRUe+Yj4pcwXVuvhbLfI5PpLk/Y8iklc24QZhq6n6bFEm6X7BDpsYS97+LZ?=
 =?us-ascii?Q?EkaTIjrRe8+dc/puBBiG+BAjaXeNnuVf6lLavxXZwA2zx4QJy0dxyqcdHq/G?=
 =?us-ascii?Q?xbv6VrBuL+SX5NQnD9ybWAPs1Ssf3k17NrmfjFyHRW422WGzzrCogNUdovZ/?=
 =?us-ascii?Q?tmvQZs3K0u/6JHTKQeBVSlC8QEu1wI7w6OP0IJjQpjDMvBchtxhPTmULdPQm?=
 =?us-ascii?Q?VUrJQvRHLpbDO+svoc2hMxwkrgPC3CAdC7moanNHGz7rnNKI1PZN4H5nHJUK?=
 =?us-ascii?Q?niaA/BHlzx8vD1QTMlARvsxoUV/B4TVUJKkIHAIAor3hVPiBPGdBdUSwJTYH?=
 =?us-ascii?Q?lXGuqoAr+VnDWxr258dCg85/bGgBbPXcxNLJ0ZBBAa84cqywPIFUWilfVoWQ?=
 =?us-ascii?Q?tTRbEx+ig3ILbb/IXluTMjNeNzqrwZ42sXpTyyg+A8lj6QbR+me8WKtYIR9X?=
 =?us-ascii?Q?7zMV/a5p8QuoOfq9kccIfUvFHtxzqrq100/JYB1s88MikP8CFodBuzgZIRUG?=
 =?us-ascii?Q?Qki9arRKZAZUwQJEdBA+8dsvoDQY2qjhlsiHVvgIgbjVlVGU61YkrRyXmc+E?=
 =?us-ascii?Q?VljIniiBZL7VJxo3xy6LoIA+1fqzThY/Lkq+9nTzLEuDcsOtbjRzTmh4QR5j?=
 =?us-ascii?Q?Hmo0qwxKceDhW9upkspUDfW20KcykgDGYEm7vgp/4U4cIm0b7Ec56ksN6V6F?=
 =?us-ascii?Q?6ErjjDcIV+zCgqVoz3eoVTNyrgSa5ojCs2ojkeo9TJfrYV7zJwh0xtxx/Dyt?=
 =?us-ascii?Q?uQM4+HHSemMVdWMmECjwajg4I4Xm69hRpdzcRSlgJs+/8ZeDx6AD57GI/4oL?=
 =?us-ascii?Q?IWVhFXK37FLbYBtnwOZEmoqi42IL+qX2ZxPT7bMvLPpsM22pnKYFTYkdJrcN?=
 =?us-ascii?Q?1K2GFikea2H+sJzNwDyNNwV4QaN0LG1c+j9MPAQ7sN0NjH30WREP7nRxhV+4?=
 =?us-ascii?Q?R1Y2Ch7eSPoGckJFtEGQDKS8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6C79EEE013E5E4C80946DF3BA8DF956@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc60ac6-ac9a-4db9-4e2e-08d8da6a2841
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 15:21:14.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyFNb/XVT1SrW93Qd4KowIXwubO2Ipgvvn/q5bZ8h5whEn2qGBHzdk2hKukr1wtiqfvS18YqOJMnv7PbfLTAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=497 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=744 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 26, 2021, at 10:19 AM, Joe Korty <joe.korty@concurrent-rt.com> wro=
te:
>=20
> On Fri, Feb 26, 2021 at 03:15:46PM +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 26, 2021, at 10:00 AM, J. Bruce Fields <bfields@redhat.com> wrot=
e:
>>>=20
>>> Adding Chuck, linux-nfs.
>>>=20
>>> Makes sense to me.--b.
>>=20
>> Joe, I can add this to nfsd-5.12-rc. Would it be appropriate to add:
>>=20
>> Fixes: 719f8bcc883e ("svcrpc: fix xpt_list traversal locking on shutdown=
")
>=20
> Sure.
> And thanks, everybody, for the quick response.
> Joe

Your patch has been added to the for-rc topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

with minor edits to the patch description.

--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290CE3481C6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhCXTUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:20:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbhCXTUX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 15:20:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJK2AB081048;
        Wed, 24 Mar 2021 19:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wmSNThYF5g4LpxL5CS7DUfMdixR0GisXKOlql+5Gl20=;
 b=JPMe5NxwmlE04tTRVyrXe/zx7+vf1jYcgHPct9EzEnIPu1tDgNt1xQnREVdr51owH1sf
 BkuVrETraukbTMOOoYvOb/cATj6VgF9exgggQXOZkqOih4Ky9FUvJqhNqbdsMlVwE/so
 u2FGMXp4TtaU4dAyvJc9aop/Cm6kOqJQ8tmklavdXPohpj6phzZC88+IHUSTOIRbU1TH
 yfsXbcVjgzcv0fSP8/2j8yeE7C2xLLqht0C8sWzHxdpkM/P6kneea8HpG9/nbzBxkGJn
 ctioef9d91+VK0DRwcBMUupKV2FnCxyDn1AgQVWwgNiZLaNHQsllViW6JRM7gsVIRCQ5 kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pn3wfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:20:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJGEo4170507;
        Wed, 24 Mar 2021 19:20:20 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by userp3020.oracle.com with ESMTP id 37dtttr4tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixWdLQ29dkDJXZy6u8oouXO9p1rbxhAwbsJLk8Lag6kLVv9VUbKDB0FnCwu8K6zdUtacz/U/Z8vQuT9E98EFQmuNkjZqyI6l/F79xUXMvCnzHFBmUr+fU3G1bZaHbK/cNDfECmMpy8DirEJaMlt1/DpEkPUtqfVtt20iyL5C6xT+/1EjvaJcm1W6affl5gyUeVv8B3QtcI2t/Hiu1m5SVtFtvTznOqs4kT22lH/RSqQQWppYEM5ciwT1xWw2son9fTKHpVU2kGDhh0ZjdVAuYgSS6mpEjBJ8VvjwyX+I1Vt6hjhoiG95eEbOWPAVeXw7VIp85Uc7sFykzg6QSlBu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmSNThYF5g4LpxL5CS7DUfMdixR0GisXKOlql+5Gl20=;
 b=TJ7FM4InurQuSip8bOFYZ415yMTudG3A4MRkunuwvv/caVjWIInyGBM5bbJOFDK4cMoJJKVgVrxbHlwLJ9raKCcIEdYrXgc0mhXnpxcsDthF8oShmbt7ttarDQygUc2vmsjgXiX1ayB9Sqm9z6W8FT1AVUuHl/UhyN/uzV0rI2SYwU8dpbbYjVshPO12ondO/UUa1x75GeGkiZ63urFjVPXaygoH1EpCO9Kl3Gi2XL6J8p61ZOhri2/iu5iFFHAuHUzRSju+ug+iJhj17z/541sWJG2YFXatHKIG1AF+o6EbGPv7IDgX+vHTet9RLI6stnIQMaeURC/jVQWOoxeOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmSNThYF5g4LpxL5CS7DUfMdixR0GisXKOlql+5Gl20=;
 b=bNvnVGvbCT4gDM/yNZ8skDwv5s7WtUysUHFfV2OVlftHev9NG91hN9EVJOpD0lRt+sM9Ti8jFk4TENzRh44gefcvVpiVQaOSY2DtSMZlwaQA4wM+W23X6Tc7qXSlrzzoMWrPCgXOBpNnaJdNxGIdhH/Sh7E4myUGxMcMki4JaC4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 19:20:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 19:20:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Pradeep <pradeepthomas@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals with FQDN.
Thread-Topic: NFSv4 referrals with FQDN.
Thread-Index: AQHXIC+RlYgV5Nu/ikG9U5ij8o1Xy6qThRKA
Date:   Wed, 24 Mar 2021 19:20:18 +0000
Message-ID: <A33B308D-1B41-4125-96A9-5DF19816D571@oracle.com>
References: <CAD8zhTB-ie445UwCJnd9qW242EzcFX9SuWJxvaU3KnB1h-dFyg@mail.gmail.com>
In-Reply-To: <CAD8zhTB-ie445UwCJnd9qW242EzcFX9SuWJxvaU3KnB1h-dFyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18b07fac-91be-47bb-a60c-08d8eef9dcb6
x-ms-traffictypediagnostic: SJ0PR10MB5406:
x-microsoft-antispam-prvs: <SJ0PR10MB54064F4DCA319054550B95CB93639@SJ0PR10MB5406.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85Xp41HtgaMBVsx2bK+NsZhHFOpKMaNMRejHl30yQ6qDFpB6txjvZekXS+EtsNthO+PZqyaqST9R4+p5UaQmI6S3KyatqE8nAkZThm/8zxGNdqc6Bmu3OFa7GlqpOsAbXr/ZLt0MWPU1KJBR0veQfs37/PsRbip5txzKeGnBJio7Nw8O+3WzvQxKoTwS/BzPHNNDRbA64WISmgAITmJm/RQgGCq2Ev5YQ6wXNFnOzPE1f3/x6Nn8mbq9uFK5rvUFipDrdSFgrwyR+gxoIvEZL8Hoek2fGxCdqNgiEVa8oPn+DeWl7URmRTmbPgcFQ5Ut0loBnpZSDtgKYVfp+xJZCI7GxnFW3hespHD0nr9XcNBbClDlcvbvMh9stXPDVBobl4iAJptslUyHane4ZgYYRpfCPiMvaZgN6MnpLwisTYl9sTMdTZogJHaqX8LZgZ26tgem+ccUB7Jna1Oahpz9SlWqiD/sQ/vlgRpXUMGsdB6jYB5V9O8o6Gf2/CNfng54x+LZKJnrDz3Pl6ZFhZ2xGxvyxjfz0tpdIX1smoXCJ9wWcJtUVrO8RYfpbBFtc0IIqzYXqDvX+bpBN4OZyt96rqsVWnyL7IWBMx21RruElM5HOcavHo7TCbentL7Xs7wVT7uzsFGSCmPmZ6gK14z5JZWbE19uJOGGT14YWDoSGcxP2v9V/g9Z/0eI3kw0/0Mk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(66476007)(66556008)(2616005)(6512007)(316002)(53546011)(83380400001)(6486002)(2906002)(6506007)(36756003)(86362001)(8936002)(6916009)(478600001)(5660300002)(8676002)(33656002)(26005)(76116006)(66946007)(91956017)(71200400001)(64756008)(66446008)(4326008)(186003)(38100700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Tku4b8t1k3wF7grzLWXEwRCF9+jVKfxEcBVBTDRpxFD89S4LuimTuV+UJ7Nz?=
 =?us-ascii?Q?Pu9NoQEmojVWwHBk4tYYr8XIMd+TvUwmfsnNyIGaahT9Rugleisw6q1MbLvt?=
 =?us-ascii?Q?iGXfz99RfHHwjn8FOO7MjvDskLB6C/Jnzl/h0I9bqvXh1WLltLnqI1b0DDUA?=
 =?us-ascii?Q?1137yvxnvAU2lC2otW76Ktg+oHOmKwjP0+ZWCmyT0Sc5d5gUKqsFAfZgZd0c?=
 =?us-ascii?Q?Vfu5vBjGfgaz5BwfqDPYCXauNn7AgO9fzQ4GJ0eL7x0nlMbzjB9EGcfouYQ1?=
 =?us-ascii?Q?Kgy4wk/DisXewFH/fkFwiRk6/Bk2YKevz3JACLu0h4eXHCcfMQoM82L/kIgP?=
 =?us-ascii?Q?QE8WGVd+RU51UxCkaEHmjBpVKUEo+e2Uh59WHUxPL6x/48udrGMnSF1oTMp5?=
 =?us-ascii?Q?RAxTC7D5dAiiQp6WboXViJ540qQePOQdV3SpD4eqx1PA6exXEkjhJADJPp9b?=
 =?us-ascii?Q?X0PxX4pFmSx88xHC609q+nfOzGvIcSe1HeQE1tX+rswHBGB0EFB1BYv912a0?=
 =?us-ascii?Q?ijk6mgaR53ZPg0JdRq5F/vySkELbhm9SVXXqGGMwoU5qB8oOhWRGJnNJsipS?=
 =?us-ascii?Q?mHPpp00qVdRH7dZAbLKvy1SdDTD4D7XlLQByU0CnRP60Swxz3IkPf6UXYZd/?=
 =?us-ascii?Q?0ONJANbKKUoV/UbJ5aKKXhZNoHmcZe19yM1JFOOHVkli/Ph2C58HhFXGt+eh?=
 =?us-ascii?Q?/WHF76MXDzapN4w5dbrMUKL6CwZlc2h/FtdKRnXQdLoRZhDtHPSOI6XI3eBJ?=
 =?us-ascii?Q?mjXH3eOnf+tKw9f5eLZ7AWFelI/7DypIic3rZCO80UpyPVSesBmMJtQPtX4N?=
 =?us-ascii?Q?6NO9zPLZNeaiQVba/7AAEEA5CzUSpTnPMqoJCl48QrmVW+QZIs1QpL6QIPc6?=
 =?us-ascii?Q?xbo6+AVavh4ivLyNBnPCMeaiuT5Xw329MzIQHecqET/QgNik6zIvkibKkqiM?=
 =?us-ascii?Q?p6900y12s3XkBE2Gg4L+jPUgLeiRKQFF6rSOHagaEC4bNaicuahshzwRvGmS?=
 =?us-ascii?Q?oVCTyHCUZtKRRCqPpbheEEE7+EezKdt50o7itLJma74UFpTmsto+vhn3rskY?=
 =?us-ascii?Q?UZoPyzYtwu8IyI7pZLr/shtz375YURklD3FOnraX17AtsQQQMh2gO8S9VCge?=
 =?us-ascii?Q?AOVfwArp+SuIuTAqJiy5HTBuGZNaZLrMQDrJNL3A4uZBUXWK2lnbqBoZ4k9Z?=
 =?us-ascii?Q?BxHeU76DKMo0ocjZ0a0niZafM7vk1GlcHLF9LmWaxckxCwffRQFh4rv/iSxv?=
 =?us-ascii?Q?US4j3P00/JqmdULwF/VV5Zps+4V05OD8CciWlFSgAdU/3UEpl/Njsh4Uy7uM?=
 =?us-ascii?Q?QtmwiDc9d3FD20EDvMK9ZOCe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22629677ABA8C74D8C0FCF219DF2EC37@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b07fac-91be-47bb-a60c-08d8eef9dcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 19:20:18.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJjy2sSv/MRKPsCR/zeQki8GbiW0SGsUAzZg85S0ghag8YUZQkQv+YBz0ZELTPX/rZF848WDBIZLr2h888LHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 5:56 PM, Pradeep <pradeepthomas@gmail.com> wrote:
>=20
> Hello,
>=20
> While testing NFSv4 referrals, I noticed that if the server name in FS
> locations does not have IPv4 mapping (server name has AAAA record for
> IPv6; but no A record in DNS), the referral mount fails.

IIRC, that is a known bug, but it has been rarely hit up to this point
(only case I'm aware of is during testing, which is how I know about
this issue).

The DNS upcall needs to be fixed to handle this case properly. As Bruce
likes to say, patches welcome!


> With debug enabled, I get something like this:
>=20
> nfs_follow_referral: referral at /nfs_export_1
> nfs4_path: path server-1.domain.com:/nfs_export_1 from nfs_path
> nfs4_path: path component /nfs_export_1
> nfs4_validate_fspath: comparing path /nfs_export_1 with fsroot /nfs_expor=
t_1
> =3D=3D> dns_query((null),server-2.domain.com,19,(null))
> call request_key(,server-2.domain.com,)
> <=3D=3D dns_query() =3D -126
> nfs_follow_referral: done
> nfs_do_refmount: done
> RPC:       shutting down nfs client for server-1.domain.com
> RPC:       rpc_release_client(ffff97fdf170c600)
> RPC:       destroying nfs client for server-1.domain.com
> <-- nfs_d_automount(): error -2
>=20
> It looks like NFS client does an upcall to "/sbin/key.dns_resolver".
> "/sbin/key.dns_resolver" works if callout info is set to 'ipv6'.
> Otherwise it fails too.
>=20
> Does this mean setups with only IPv6 records (AAAA records in DNS),
> NFSv4 referrals won't work if server returns FQDN in referral? If
> anyone has tried this and made it work, please let me know.
>=20
> Thanks,
> Pradeep

--
Chuck Lever




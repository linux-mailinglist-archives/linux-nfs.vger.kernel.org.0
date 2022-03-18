Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8A4DDFCD
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 18:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiCRR0m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiCRR0l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 13:26:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E91D7623
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 10:25:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22IGLIEc017014;
        Fri, 18 Mar 2022 17:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iBa7Mbz64br1gn2kcvguLEy4nfwSbkLPPRi6mmgS3BA=;
 b=PGhiCg9Ox1rzeTiGM9oBhJ2bVCbLko8tyPGzHSsPAwyZS2fa93zrVubmORPQjrGePGeY
 4jvuo7JQ377FKdHlrLzvx8b3uElRvFKwHp98swm9iVmmL+3Qulfcm37M7904s81NvrkH
 NFssGvOo8hzTDqSHgf7XGMDfPS4Okj/12JcHId+7Z9tBG+qeQO02QJ3F/uBMWLe0ZwqL
 f3373kvUpd9MTe6QncF32P3ZvBsX1nf+eSCnmwvtsf+x/pncXemohuIzGoosk+0A4TNx
 0AYgMllayMe0fEkcylKjSKY0BsU5blwXYHTErvnZzDV88kn7VZFQvMKsRMCOvSVYqUWp CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwv3a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 17:25:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22IHG40s089612;
        Fri, 18 Mar 2022 17:25:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3et65ac755-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 17:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8ljjzd3r2HiiGb/+Twnp3RZsaWip34110QRldVKO4ssopqlUek3rMFah4IqdLHUHjgJzQ+BFAGWhKYXB+feThYl8+55pkJUCqzwV1yHB+y5Qw2EsA71rT/2i/y0MSLDNY+q05idLZPf6pweeMXQLSNYPliW4spzOLmOWGM9DmwKjfUgfa3PY5MtnXO5VulDrUgtXA0rSIFgVuC2TwZwlvnBpiTduybUi1pMIabP6/uEfE63hwMfkd3DCKRndPH5oj+uIJmNihzZa9sI9YP0p0w1cRi46YtaPe4cyjok5zsU2rIi+Ce5hojzE4qGYPwtFfQ6czCZQNdxDgb71vn/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBa7Mbz64br1gn2kcvguLEy4nfwSbkLPPRi6mmgS3BA=;
 b=ITjUbOB1LJI+40VCH1YvFwcA4frk3q0b0dsPq/6PdJYQ4yMUTRKKb5TV3xypslc4uQQkmLeOZQ5mza/jm4KBtg0Gd7LpWgeiDi6+XlTGYKNT8U9CedsAqvamuwI/92Frf07KTq23+BW7ZjDP4S1jweAUGz5AoohfRzOLHU0yDCT3kGGxxTWu3bUJOpoSQYR3OkcsONucHwyQw89wh8fzLcOvRbo2csfDn0Tj50JQr7GEPz2irVBN2HcpkCjnBFyj7BlUAqLaFUcRMpxtVLJDY05jTVKBT8RKsa1yaYfqS8cmVqmITbtHcTu719EkYJZtKZkF4y3ktlmkTF1541ZcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBa7Mbz64br1gn2kcvguLEy4nfwSbkLPPRi6mmgS3BA=;
 b=o9hdqyKQjMJOZpM10IjLNBEolooB9THslFEJKU6hhQmN8+zB/VYR8sDeS1N8qWDdPS6QfKGLvPp0g8hBbt5F+PxECno7n/8CZS356Lc3D+4hUbTNvKt1naJEq3EDKC7WCWKDV0rD3JmCzbqhlox1LjR0lRlcG2g8Mjf8TkijPCc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 17:25:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 17:25:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Topic: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Thread-Index: AQHYNz9tXzp0vUT6Z02tg1tG8znMeKy/CFqAgACT9wCAApGeAIACO2UAgAECZoA=
Date:   Fri, 18 Mar 2022 17:25:08 +0000
Message-ID: <9D0A7A61-BCF4-4A1B-B462-5F1402EE0B2E@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
 <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>
 <164730488811.11933.18315180827167871419@noble.neil.brown.name>
 <9A7BF2ED-E125-4FEF-B984-C343C9E142F0@oracle.com>
 <164756881642.24302.4153094189268832687@noble.neil.brown.name>
In-Reply-To: <164756881642.24302.4153094189268832687@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f0c471a-725e-497f-ab51-08da09043fec
x-ms-traffictypediagnostic: PH0PR10MB4552:EE_
x-microsoft-antispam-prvs: <PH0PR10MB45525D996626DDE2E77BC9D793139@PH0PR10MB4552.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uORBo4erEx2Vda1lVBiMdBZG+mC2Al/ERt+fUkjcdTNFJ5z1+GVvGvRtTp0Xv+QyEkClypFAr3wsiJgRqGVt21gEN3Zs6yWihtQjBL50epSAFE3LNFLWY0Q2Xc2clz4cBrNqBLuJfguIhrBqV4Nu/NJrQllmKCoqeNG4Wy/lNwXE2kWCHIdDdUE4Vl7aRGS4kTOLvjxa/D/qHNkBw42Ipw8R1sMhQ8McT4aipQ8C+5qwx5mLUTm3Sjt4hlTYoQfBolRN8BJA9n1b3rjqVHsJNZgBH4htOqDt1KUMm+oGQkwl+0iVv7/j/C5wmPPBOK35IiRH0mFaDV/WjKpnt4rcOiB7wjmIyuoSKWV3WBaWizpHsn1/cpbSpxr7/S2w7zY/T8H93xE44an7egzHmdoTmuCCTyQt46GTuiOV4JiL9SnGWvy8MavP/gDPnX1gUFXayg7sS+EdEQsclRsrXqPBEgjCXdrTDfwIrVubOVq2QIjt3HPmDQHFcSo95YXyrtoxJGtYR94bYVqaR1ZwVrX7qO80rbprQyzvYI7Q5lB9ss2pvPwTYQsvsYFFDos5Kvq3yxlUE+bCc7yHya6ed3hZDokIxswxllYpCCtEmZ/eIxEy8KPizhvFICFOoPz0CpaLM4Vt0SweQPJtQ5p0PcKsG0J1w5lOl45NqcaWhdqf6XuU7Dw4w3MwlGUR3O6qocftMxb2PqU2cFlesKeKqBX37yT2PEZ3G4VtIRIWLqfjBzGByZGWyiTz9F1/y19yTDEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6512007)(38070700005)(53546011)(30864003)(186003)(83380400001)(38100700002)(6486002)(2906002)(122000001)(26005)(316002)(4326008)(5660300002)(8676002)(2616005)(66446008)(66556008)(64756008)(508600001)(66476007)(66946007)(76116006)(71200400001)(6506007)(33656002)(8936002)(86362001)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vfN1eQb6VQjjqmToj/RCEbjP+/ryL9PCYHLKRiwl79WxYmCTcDMegB3g4JAp?=
 =?us-ascii?Q?l5EHG2Cpo4zrxQt2sLC4WCqk3Ho7SRdgG16LmDvS+dk33i22muVIdTBE0JHq?=
 =?us-ascii?Q?5W5J+Z6CT0hvxz5SiqI7iS/MBnBaFud26nlLNjPbXXTVol7F7ZJi3AC0wcR6?=
 =?us-ascii?Q?s9sHajsc3g+0xQRcOggn2bgHwCVCwlquOdLuYCuVPf4L9smsnslSOT4T/+0B?=
 =?us-ascii?Q?/wp8G0KzdFEpB9WaRtGr/5pMJBz8YpsOxn65GsvCzIGeSAx/KSgMh2+CjMRE?=
 =?us-ascii?Q?qd2h1D+knD1iKdQ+Sc+y568pyXONpuYI/Nx/mlI0UDO2C/qy0v+54O4cM92i?=
 =?us-ascii?Q?zxDntd2cl1K9OdocPZAmacRhsxCV4E+SMzppRf/062w87x7txt53E4grrzze?=
 =?us-ascii?Q?Afaqq7M1gI5tKyUm3Y36mFyBh7P8T6yPu1NNLlRlkfsvUcyHt/DFcAgv9spy?=
 =?us-ascii?Q?O/L6wLh+sAXrUke09HOUjNzDU1dz3a5FjCu61OJemrbrIAg7YTR7IjBOVbWY?=
 =?us-ascii?Q?p42ihd7WFL1E3AwMABnfo/D56l0duXKweOKxoNhwPg4mO+t47l4Dwp7uJv49?=
 =?us-ascii?Q?+pus4i0WVz73LR9wPmHBKYevFaaB6IiFNg8KHOKEpzKwu9epw73pzbhffEHa?=
 =?us-ascii?Q?dZcpoLml7fQIqUC67iX42imtLIFJw6V/XNLf8LLpZvSxC8kKYDxm9uae6LJu?=
 =?us-ascii?Q?tWV+z06Y/AMac8zrHnZHng1wyDzmGHHUl7F3BMBtPWcAvZvCgyJOlVJ6BP0w?=
 =?us-ascii?Q?wEcMrC7mVd/kii688aTJWBfGlNvKk6r1pmolLTltrqcoWsiSJw8j3aefh5Or?=
 =?us-ascii?Q?sbA1FJkB7wCPy5uMfBB1/zpHo82sDHtTqtYlb8MC+F6KvQ2SDa3Lh4UFRspv?=
 =?us-ascii?Q?q4om19uqvsmPP66su1cY4Wmiygq3Ur0yRvJ6bV0BJ68g3jfY4azUlWEks7JZ?=
 =?us-ascii?Q?vBPfPlcMcA2MBm3kIYLnx1EnUTgGHqb1DeJgXLh8/Q4W3JbBrlZT0dV1bF6L?=
 =?us-ascii?Q?yCo6ytBl5stzmrQVNuO5AaM/GcLTY9AdBVbqgIgglkJf4gmyk2p/JETpNzUY?=
 =?us-ascii?Q?9LDDF9OZ4bKHq/iZ5jh2qmf6SKqHqOmPpLqu7ih7Hzrousq8Mz9wzE+gPB/M?=
 =?us-ascii?Q?8cPzNKnZhmrHvqhe1W9M5lkjBSo7MYmKZdSjeZhWjQryS4rx/n5tosD+1q9D?=
 =?us-ascii?Q?8ev0eBiOiPabgr9bEpQZ8OXV3qaElQ4XSRr8hQYEV+wGCTZsloUQRvazbuQU?=
 =?us-ascii?Q?8CeRBIq6IQiv3hkT9vqLwGM0gQEYYnGRoexGt/86/b/BI23AGZ2R4TfNSIfM?=
 =?us-ascii?Q?eZjOp9o/pS0SSWnJghml4P6SxMoPpb1+5k3EzF/xmIpBf/fwdVtVPGS+pFYe?=
 =?us-ascii?Q?hoPpUnjz6IDY8oTPOyD4WLbvaThLE++I481SdAIc18457uKaA1wMl4YHeC++?=
 =?us-ascii?Q?dlwvQnUvVeKIRbrh5tZ6Xvte25EXc9O7yk47IwAIbUpa2G6kzJ8RAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CB76A76A0FFAC49952F8D6A09BEA412@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c471a-725e-497f-ab51-08da09043fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 17:25:08.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tzga3F76CNWvgm1MPdtyp6Dt4C95Mh42q/y3OZaM7Azotj2rseBhnpZ1tqtYGg1wmMhoT9Wj1ONJPIe58Cya2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180092
X-Proofpoint-GUID: ZGIw9Ys94UeEmcBJgWOTyVhvFhGwzI6V
X-Proofpoint-ORIG-GUID: ZGIw9Ys94UeEmcBJgWOTyVhvFhGwzI6V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2022, at 10:00 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 17 Mar 2022, Chuck Lever III wrote:
>> Howdy Neil-
>=20
> G'day
>=20
>>>> The last sentence is made ambiguous by the use of passive voice.
>>>>=20
>>>> Suggest: "When hostname uniqueness cannot be guaranteed, the client
>>>> administrator must provide extra identity information."
>>>=20
>>> Why must the client administrator do this?  Why can't some automated
>>> tool do this?  Or some container-building environment.
>>> That's an advantage of the passive voice, you don't need to assign
>>> responsibility for the verb.
>>=20
>> My point is that in order to provide the needed information,
>> elevated privilege is required. The current sentence reads as
>> if J. Random User could be interrupted at some point and asked
>> for help.
>>=20
>> In other words, the documentation should state that this is
>> an administrative task. Here I'm not advocating for a specific
>> mechanism to actually perform that task.
>=20
> ???  This whole man page is primarily about mount options, particularly
> as they appear in /etc/fstab.  These are not available to the non-admin.
> Why would anyone think this section is any different?

Because the nfs_client_id4 uniquifier is not a mount option and
isn't mentioned anywhere else. It's not going to be familiar to
some. As you and I know, most people are not careful readers.

Do note that nfs(5) is really just an extension of mount(8).
The sections you pointed to earlier (eg, DATA AND METADATA
COHERENCE) are there to provide context explaining how to use
NFS mount options. The patch you have proposed is for an API
and protocol element that have nothing to do with NFS mount
options. That by itself disqualifies a proposed addition to
nfs(5).

I suggest instead constructing an independent man page that
is attached to the /etc file that contains the client ID
uniquifier. Something akin to machine-id(5) ?


>>>> I have a problem with basing our default uniqueness guarantee on
>>>> hostnames "most of the time" hoping it will all work out. There
>>>> are simply too many common cases where hostname stability can't be
>>>> relied upon. Our sustaining teams will happily tell us this hope
>>>> hasn't so far been born out.
>>>=20
>>> Maybe it has not been born out because there is no documented
>>> requirement for it that we can point people to.
>>> Clearly containers that use NFS are not currently all configured well t=
o do
>>> this.  Some change is needed.  Maybe adding a unique host name is the
>>> easiest change ... or maybe not.
>>=20
>> You seem to be documenting the client's current behavior.
>> The tone of the documentation is that this behavior is fine
>> and works for most people.
>=20
> It certainly works for a lot of people.  Many people are using NFSv4
> quite effectively.  I'm sure there are people who are having problems
> too, but let's not fall for the squeaky wheel fallacy.

For some folks it fails silently and/or requires round trips
with their distributor's call center. I would like not to
discount their experience.


>> It's the second part that I disagree with. Oracle Linux has
>> bugs documenting this behavior is a problem, and I'm sure
>> Red Hat does too. The current behavior is broken. It is this
>> brokeness that we are trying to resolve.
>=20
> The current behaviour of NFS is NOT broken.  Maybe is it not adequately
> robust against certain configuration choices.  Certainly we should make
> it as robust as we reasonably can.  But let's not overstate the problem.

Years of bug reports suggests I'm not overstating anything.

The plan, for a while now, has been to supplement the use of
the hostname to address this very situation. You are now
suggesting there is nothing to address, which I find difficult
to swallow.


>> So let me make a stronger statement: we should not
>> document that broken behavior in nfs(5). Instead, we should
>> fix that behavior, and then document the golden brown and
>> delicious behavior. Updating nfs(5) first is putting
>> DeCarte in front of de horse.
>>=20
>>=20
>>> Surely NFS is not the *only* service that uses the host name.
>>> Encouraging the use of unique host names might benefit others.
>>=20
>> Unless you have specific use cases that might benefit from
>> ensuring hostname uniqueness, I would beg that you stay
>> focused on the immediate issue of how the Linux client
>> constructs its nfs_client_id4 strings.
>>=20
>>=20
>>> The practical reality is that a great many NFS client installations do
>>> currently depend on unique host names - after all, it actually works.
>>> Is it really so unreasonable to try to encourage the exceptions to fit
>>> the common pattern better?
>>=20
>> Yes it is unreasonable.
>>=20
>> NFS servers typically have a fixed DNS presence. They have
>> to because clients mount by hostname.
>>=20
>> NFS clients, on the other hand, are not under that constraint.
>> The only time I can think of where a client has to have a
>> fixed hostname is if a krb5 host principal is involved.
>>=20
>> In so many other cases, eg. mobile computing or elastic
>> services, the client hostname is mutable. I don't think
>> it's fair to put another constraint on host naming here,
>> especially one with implications of service denial or
>> data corruption (see below).
>>=20
>>=20
>>>> Maybe I'm just stating this to understand the purpose of this
>>>> patch, but it could also be used as an "Intended audience"
>>>> disclaimer in this new section.
>>>=20
>>> OK, so the "purpose of this patch" relates in part to a comment you mad=
e
>>> earlier, which I include here:
>>>=20
>>>> Since it is just a line or two of code, it might be of little
>>>> harm just to go with separate implementations for now and stop
>>>> talking about it. If it sucks, we can fix the suckage.
>>>>=20
>>>> Who volunteers to implement this mechanism in mount.nfs ?
>>>=20
>>> I don't think this is the best next step.  I think we need to get some
>>> container system developer to contribute here.  So far we only have
>>> second hand anecdotes about problems.  I think the most concrete is fro=
m
>>> Ben suggesting that in at least one container system, using
>>> /etc/machine-id is a good idea.
>>>=20
>>> I don't think we can change nfs-utils (whether mount.nfs or mount.conf
>>> or some other way) to set identity from /etc/machine-id for everyone.
>>> So we need at least for that container system to request that change.
>>>=20
>>> How would they like to do that?
>>>=20
>>> I suggest that we explain the problem to representatives of the various
>>> container communities that we have contact with (Well...  "you", more
>>> than "we" as I don't have contacts).
>>=20
>> I'm all for involving one or more container experts. But IMO
>> it's not appropriate to update our man page to do that. Let's
>> update nfs(5) when we are done with this effort.
>=20
> Don't let perfect be the enemy of good.
> We were making no progress with "fixing" nfs.  Documenting "how it works
> today" should never be a bad thing.

To be clear, I don't have a problem with documenting the current
behavior /somewhere else/. I do have a problem documenting it in
nfs(5) as a situation that is fine, given its known shortcomings
and the fact that it will be updated in short order.


> Obviously we can (and must) update
> the documentation when we update the behaviour.
>=20
> But if some concrete behavioural changes can be agreed and implemented
> through this discussion, I'm happy for the documentation to land only
> after those changes.
>=20
>>>>> +.IP \- 2
>>>>> +NFS-root (diskless) clients, where the DCHP server (or equivalent) d=
oes
>>>>> +not provide a unique host name.
>>>>=20
>>>> Suggest this addition:
>>>>=20
>>>> .IP \- 2
>>>>=20
>>>> Dynamically-assigned hostnames, where the hostname can be changed afte=
r
>>>> a client reboot, while the client is booted, or if a client often=20
>>>> repeatedly connects to multiple networks (for example if it is moved
>>>> from home to an office every day).
>>>=20
>>> This is a different kettle of fish.  The hostname is *always* included
>>> in the identifier.  If it isn't stable, then the identifier isn't
>>> stable.
>>>=20
>>> I saw in the history that when you introduced the module parameter it
>>> replaced the hostname.  This caused problems in containers (which had
>>> different host names) so Trond changed it so the module parameter
>>> supplemented the hostname.
>>>=20
>>> If hostnames are really so poorly behaved I can see there might be a
>>> case to suppress the hostname, but we don't have that option is current
>>> kernels.  Should we add it?
>>=20
>> I claim that it has become problematic to use the hostname in the
>> nfs_client_id4 string.
>=20
> In that case, we should fix it - make it possible to exclude the
> hostname from the nfs_client_id4 string.  You make a convincing case.
> Have you thoughts on how we should implement that?

This functionality has been implemented for some time using either
sysfs or a module parameter. Those APIs supplement the hostname
with whatever string is provided. I don't think we need to
exclude the hostname from the nfs_client_id4 -- in fact some folks
might prefer keeping the hostname in there as an eye-catcher. But
it's simply that the hostname by itself does not provide enough
uniqueness.

The plan for some time now has been to construct user space mechanisms
to use the sysfs/module parameter APIs to always plug in a uniquifier.
That relieves the hostname uniqueness dependencies as long as those
mechanisms are used as often as possible.

So in other words, today the default is to use the hostname; using
the random uniqifier is an exception. The plan is to make the random
uniqifier the default, and fall back on the hostname if for some
reason the uniquifier initialization mechanism did not work.


>>> The hostname is copied at boot by NFS, and
>>> if it is included in the /sys/fs/nfs/client/identifier (which would be
>>> pointless, but not harmful) it has again been copied.
>>>=20
>>> If it is different on subsequent boots, then that is a big problem and
>>> not one that we can currently fix.
>>=20
>> Yes, we can fix it: don't use the client's hostname but
>> instead use a separate persistent uniquifier, as has been
>> proposed.
>>=20
>>=20
>>> ....except that non-persistent client identifiers isn't an enormous
>>> problem, just a possible cause of delays.
>>=20
>> I disagree, it's a significant issue.
>>=20
>> - If locks are lost, that is a potential source of data corruption.
>>=20
>> - If a lease is stolen, that is a denial of service.
>>=20
>> Our customers take this very seriously.
>=20
> Of course, as they should.  data integrity is paramount.
> non-persistent client identifier doesn't put that as risk - not in and
> of itself.
>=20
> If a client's identifier changed during the lifetime of one instance of
> the client, then that would allow locks to be lost.  That does NOT
> happen just because you happen to change the host name.  The hostname is
> copied at first use.
> It *could* happen if you changed the module parameter or sysfs identity
> after the first mount, but I hope we can agree that not a justifiable
> action.
>=20
> A lease can only be "stolen" by a non-unique identifier, not simply by
> non-persistent identifiers.  But maybe this needs a caveat.

In this thread, I refer mostly to issues caused by
nfs_client_id4 non-uniqueness.

This is indeed the class of misbehavior that is significant
to our customer base. Multiple clients might use
"localhost.localdomain" simply because that's the way the
imaging template is built. Or when an image is copied to
create a new guest, the hostname is not changed. Those are
but two examples. In many cases, client administrators
are simply not in control of their hostnames.

In cloud deployments, AUTH_SYS is the norm because managing a
large Kerberos realm is generally onerous. Thus AUTH_SYS plus
a hostname-uniquified nfs_client_id4 is by far the common
case, though it is the most risky one.


> If a set of clients are each given host names from time to time which
> are, at any moment in time, unique, but are able to "migrate" from one
> client to another, then it would be possible for two clients to both
> have performed their first NFS mount when they have some common
> hosttname X.  The "first" was given host X at boot time, it mounted
> something.  The hostname was subsequently change to Y and some other
> host booted and got X and then mounted from the same server.  This
> would be seriously problematic.  I class this as "non-unique" hostnames,
> not as non-persistent-identifier.
>=20
>>                                        The NFS clients's
>> out-of-the-shrink-wrap default behavior/configuration should be
>> conservative enough to prevent these issues. Customers store
>> mission critical data via NFS. Most customers expect NFS to work
>> reliably without a lot of configuration fuss.
>=20
> I've been working on the assumption that it is not possible to provide
> ideal zero-config behaviour "out-of-the-shrink-wrap".  You have hinted
> (or more) a few times that this is your goal.  Certainly a worthy goal if
> possible.  Is it possible?
>=20
> I contend that if there is no common standard for how containers (and
> network namespaces in particular) are used, then it is simply not
> possible to provide perfect out-of-the-box behaviour.  There *must* be
> some local configuration that we cannot enforce through the kernel or
> through nfs-utils.  We can offer, but we cannot enforce.  So we must
> document.
>=20
> The very best that we could do would be to provide a random component to
> the identifier unless we had a high level of confidence that a unique
> identifier had been provided some other way.  I don't know how to get
> that high level of confidence in a way that doesn't break working
> configurations.
> Ben suggested defaulting 'identity' to a random string for any network
> namespace other than init.  I don't think that is cautious enough.
> Maybe if we did it when the network namespace is not init, but the UTS
> namepsace is init.  But that feels like a hack and is probably brittle.
>=20
> Can you suggest *any* way to improve the "out-of-shrink-wrap" behaviour
> significantly?

Well it sounds like we agree that making the random uniquifier
the default is a good step forward. Just because this has been
contentious so far, I think we should strive for something that
is a best effort but clearly a step up. The fall back can use
the hostname. Over time the remaining gaps can be stopped.

Here are some suggestions that might make it simpler to implement.

1. Ben's tool manufactures the uniqifier if the file doesn't
   already exist. That seems somewhat racy. Instead, why not
   make installation utilities responsible for creating the
   uniquifier? We need some guarantee that when a VM is cloned,
   the uniquifier is replaced, for instance; that's well
   outside nfs-utils' sphere of influence.

   Document the requirements (a la machine-id(5)) then point
   the distributors and Docker folks at that. I think that is
   your plan, right? I've done the same with at least one of
   Oracle's virtualization products, while waiting for a more
   general upstream solution.

   Then, either each mount.nfs invocation or some part of
   system start-up checks for the uniquifier file and pushes
   the uniquifier into the local net namespace. (Doing this
   only once at boot has its appeal). If the uniquifier file
   does not exist, then the NFS client continues to use a
   hostname uniquifier. Over time we find and address the
   fallback cases.


2. The udev rule mechanism that Trond proposed attempted to
   address both init_ns and subsequent namespaces the same way.
   Maybe it's time to examine the assumptions there to help
   us make more progress.

   Use independent mechanisms for the init_ns and for subsequent
   net namespaces. Perhaps Ben already suggested this. Looking
   back over weeks of this conversation, these two use cases
   seem fundamentally different from each other. The init_ns
   has to handle NFSROOT, can use the boot command line or the
   module parameter to deal with PXE booting and so on. The
   Docker case can use whatever works better for them.


3. We don't yet have a way to guarantee that the uniquifier is
   in place before the first NFS mount is initiated. Talking
   with someone who has deep systemd expertise might help. It
   might also help at least in the non-container case if the
   uniquifier is provided on the kernel command line, the same
   way that root=3D is specified.


4. An alternative for the init_ns case might be to add a
   mechanism to initramfs to set the client's uniquifier.
   On my clients where containers are not in use, I set the
   uniquifier using the module parameter; the module load
   config file needs to be added to initramfs before it
   takes effect.


>>>> If we want to create a good uniquifier here, then combine the
>>>> hostname, netns identity, and/or the host's machine-id and then
>>>> hash that blob with a known strong digest algorithm like
>>>> SHA-256. A man page must not recommend the use of deprecated or
>>>> insecure obfuscation mechanisms.
>>>=20
>>> I didn't realize the hash that uuidgen uses was deprecated.  Is there
>>> some better way to provide an app-specific obfuscation of a string from
>>> the command line?
>>>=20
>>> Maybe
>>>   echo nfs-id:`cat /etc/machine-id`| sha256sum
>>>=20
>>> ??
>>=20
>> Something like that, yes. But the scriptlet needs to also
>> involve the netns identity somehow.
>=20
> Hmmm..  the impression I got from Ben was that the container system
> ensured that /etc/machine-id was different in different containers.  So
> there would be no need to add anything.  Of course I should make that
> explicit in the documentation.
>=20
> I would be nice if we could always use "ip netns identify", but that
> doesn't seem to be generally supported.

If containers provide unique machine-ids, a digest of the
machine-id is fine with me.

Note that many implementations don't tolerate a large
nfs_client_id4 string, so keeping the digest size small
might be needed. Using blake2 might be a better choice.

--
Chuck Lever




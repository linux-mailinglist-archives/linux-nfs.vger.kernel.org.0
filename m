Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4176163EF
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKBNh6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBNh5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 09:37:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F12A26C;
        Wed,  2 Nov 2022 06:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1T/5k5fEoN+bjGJAIhuP+OM1txAD8sdz9qqxhrX/xecwW6IUrQUD68ST6l1KghEq/Xs6h1YQvWV6VI/1A+v7Ag/JyMVYfctmanAPsxpfPy4p4MgB10jtDT/VFEXNv2AN3zwQchi3A2pSwyUVvT174ebnQMyxPjnTpSOqFzZ5GTEoo+ulx+1wcVW0kRFEkmhvoScdz34O5HnKvRCMKUobnxYnAke1eaCTAU7+Loy+RohxwaYOQsKn+czFktATYblr5qgV22z/stGuXaJLQg8vFug0vtH5qemtM+fzF7vVqiwbU67THU6rJkpz5/ZL38E+6yKfupNccoGa0XDpouGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzA74CWTGiRB35XuNdJaQJz0siWR3TtFKRVKyH1M0zM=;
 b=GdpzAQJ44DztNSphgtYdbfY+58/cUNV4S4Y5p0KczV4k96LmgUOKHsoUn9lnEfvaSNyW9UBBZsOmZRKiQqEZWwx2LRfWxr41DvpuE3ORZ5nSOguRCN8j0/iEqhECgcLOyMSxhFzFxKS3RwrG/PM6nOzTPfK98MyECu8BjZ0jQQVQVzec9eib+szjqTKPKZvRWRgjpVsGzX3TYMcLyRKk7ynb1tEx06G2kYYBFKILdxNruXBr907fE2UjjzCbrDbTLZgwOqaMj+/A0y96kkabC2hBywuI/9dGq1fvvfH79cBQRbFV8GQRDKkoGtTJtEQc3TJw15ygFTz4U8ZRAOrjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzA74CWTGiRB35XuNdJaQJz0siWR3TtFKRVKyH1M0zM=;
 b=Ho9/nNrfUtPKCqVLS/0KIcLsD+5Vd09vQxY/xPWUKG8AwGOsfWAIrOaqtZz3SpdzfgirAzwqsxRCzn4YQXMSL5jBnCHiVxQBBk8xBNAkQM+YK+QGYiutuJFZxuE3Dh3rUoAPqw6medSKn4dG7assBiGtSbMQT/nCojq+w/o2uF4=
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com (2603:1096:603:2b::11)
 by TYCPR01MB7702.jpnprd01.prod.outlook.com (2603:1096:400:17b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 13:37:53 +0000
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::45f9:e2f:2ac2:e8e2]) by OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::45f9:e2f:2ac2:e8e2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 13:37:52 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: RE: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Topic: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Thread-Index: Adjp191PvyyHwERbQa6sSzLdPAGESQDJ022AAG/74zA=
Date:   Wed, 2 Nov 2022 13:37:52 +0000
Message-ID: <OSAPR01MB1843224082D47CC4C1E7352BD9399@OSAPR01MB1843.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1854FB85D24BDED2B490B8E6D9339@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <Y1+BKY/nrDtTqkEZ@infradead.org>
In-Reply-To: <Y1+BKY/nrDtTqkEZ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1843:EE_|TYCPR01MB7702:EE_
x-ms-office365-filtering-correlation-id: dff7fb25-f980-4cf0-8ca3-08dabcd770f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MFc5N48uFTmEFp9+stapctudrC8VNuxbi/0Dchu4gQ48tiSsD7gtJ1XNxTXNxl+7Q4Q0jx/CDhl/aK0SqvKIHAXVBw4fcO4XUIwDnlTQ/yAHvMWg8hAOMw6gmZzqgTEtYjaKFQhlfnSsfX7+C6WPUyxkCi1qomlXe0RCsaVphaZIsCzFTTm/XnsfbbbvJ/zHp5woMbrFPsVZ18TZNQvVzGyH5obqnIc6LsyrRTkE0Z6rcgMBpdIwNVaHYOnn8PmaZAdS4OWEhpzoK1UuDsadD8HhkblcXBHBLExBbJnDdOK+smt5P2eNa8p4KckINTNNJBYF+j09Ev8qxITmgBx43gFhUBwNp4MUB4q76oPZenPvGHcVuAfiZhUB62zxF0tjZbIcre72BBshwINXmi5B0qgJGnD0xbyDvxwkmKnSzb8MLjsPPUQv8R37hDIytFOYApAs2hQtFNS3BqyaDOWNjdEtyUcJRdU7ShpZ0ecIMTiZYRe4sd2LqXrT2k8xFrsU9BGVEwWSgcz+D+3XDv8joECmsauDvTrcZQaaDNbjbCRZHryClACoPGxqzVo0aE1yCwKmzUs0FwLahlKtmgX6/wA+wYu/bHInUQZ73CF/6nFPIKHv1wB6EE0VGxy90vSxhXtuZngKmuv1pXKGTrfn22tuYcIDThd/3aPlDNTWTmhJ4LOJc1jbmlZdW1qIFdFSNerkt+nobxQByJiZ1pfvUd96TlyJT2bkLd4o+bi/frjKR4KkhuZitSGojQkJh/qGtuy4+Rj+ElYP108uhMjHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1843.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(53546011)(7696005)(6506007)(38100700002)(5660300002)(122000001)(26005)(8676002)(4326008)(45080400002)(86362001)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(54906003)(6916009)(76116006)(52536014)(8936002)(478600001)(41300700001)(55016003)(33656002)(38070700005)(71200400001)(9686003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?6NBD/kadcPdNl759Pf8sL6JXBD+iVjs3IL0RocEE0+YUMTbdn5iQ+6HRVR?=
 =?iso-8859-2?Q?Rze2IC5qEIdrkfM2kyV9ieYrtuKx2mCAHHkb3jnIDZJF1foCOCTH+GGkYb?=
 =?iso-8859-2?Q?vyDmxkyQRNBjinIQv9VWTsVWgu4r2jG8ZiyrmiQo45frebubx6dZq/nZo+?=
 =?iso-8859-2?Q?EWjuAG1GlhqxLsjxbpZf2743GV6NtWBdA7uP1sr1IuJhaogHVLYNXZy01E?=
 =?iso-8859-2?Q?PVe15poCmwQmUOhqjeYVYSp0B/jaBtKxfkc3NW693P3AGVILt5GnpUuRdV?=
 =?iso-8859-2?Q?Dq5rjjFN8fTqiC40JQEcqQXBY1/hB1D1vkZXsSRI4ApOyG76cvN7HjfOZq?=
 =?iso-8859-2?Q?xNTyIU/qGJ/5b81q1b0b7+0TW/AvFQo4vWLrNn1U5zIelR8KPAXbMv4wZL?=
 =?iso-8859-2?Q?PC5vzt6ZKAjOjnlYlManSlOxX+bXIBGX9yS06N3CdXX/aorNcD3c51Wu8Q?=
 =?iso-8859-2?Q?EnN4XVQ+uH7qN/VmcdXx52bzTMkD6GeMDTMXfn1xAORMBrUBCznis9J+dD?=
 =?iso-8859-2?Q?38UEMFphzJIwMHKn6fob4XHprdMO9JEp527LwLhR+u4jx/xh/G9pFEMlXo?=
 =?iso-8859-2?Q?LpwEG8g2yX9QsL3Sib5Q6UONZdw6U0uA5VTVzdYvewi8G+6z5VHPIsoS3W?=
 =?iso-8859-2?Q?zi7kmonfd9+VwjJC9ysVdielo/lJZvSILWkDW9h9qBFULRGWtuttZixhsL?=
 =?iso-8859-2?Q?tP2lZGG004ThvpRhZv9QDDN55WaVWTffV8mVaxpzwjM/zzNlkLFUkRT6/4?=
 =?iso-8859-2?Q?u9wAcgQGyLta31496Iw7fm+dY+jsMb7T+QoHyv12jQYJS0URtF/wGDgQ+z?=
 =?iso-8859-2?Q?EBoVLQ3fMKoCPf4u+7SVTr4DGyZEOIfY8tqKGbPSGBHVkafZE6OByYd12b?=
 =?iso-8859-2?Q?KbfN8ImgrmwZJjIweabYpwnxK6dFexcTRpa6VtKTPlQsbrC0DAyHv5lLHb?=
 =?iso-8859-2?Q?UOBNLL0p0tvBcUzYGEZaaTG43i1ix5xWkBJUc83UuHBMUC+MmFnVBiPCEI?=
 =?iso-8859-2?Q?/Y5BoHKgMLGrgdS3/ld2nydcTVxP16un2+rzVlinBjCa3AqLisXJ+CQ3iM?=
 =?iso-8859-2?Q?2Jzb/5n88Xcog4DK6GsSR1Vzm+4gdTmvKGBIdl4WVj0x1tppzebc8r0kNT?=
 =?iso-8859-2?Q?9ccAZElmh0Lacn6kpRAiapaGAZCgsGexV5EeKnuewdiLtzP3cJJqh00XP9?=
 =?iso-8859-2?Q?uUNYqfsc6TmKDMQDjHKwGAFdd/G05EgWo/RsDZDHKj+1rMiUsoA/UM3TYZ?=
 =?iso-8859-2?Q?aTnQUJSwLdI/84dVZ5B5VY1umojWnFjLI79AyYlkaQqZ7sK78bmhzYZ/rx?=
 =?iso-8859-2?Q?17FrClPTOEXUDE3G37yY9SoV96Ikv7ccz1lf6hAQ/anL8xnZCCJKArQXgg?=
 =?iso-8859-2?Q?g7t7sh6XZmnbMZNz0Mi5Ou0lD4UpGMj+xrR4D6cyiONRR8NrQ66PjG6b9b?=
 =?iso-8859-2?Q?DNlas+yar75H7LregUDBLZ0iZmoGJyiZiwIP02iUFcxFQKLFnmLbKuSUae?=
 =?iso-8859-2?Q?RgcKlH5WkIQRSIVEitw/8ZMTmpWmhRMhdbNQAMinntEXjFGlL+EOS5aa6K?=
 =?iso-8859-2?Q?G3FfohjftGnDNqADH4GE4CpBtK2W4HQhjd4DedNT373yzvjt2ZoTc4nu8S?=
 =?iso-8859-2?Q?sioKrh0iPBvzB8Asf9Nf8AeNYeoLU9hQ3JSjrPny1bUuik5XkkDeHWpw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1843.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff7fb25-f980-4cf0-8ca3-08dabcd770f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 13:37:52.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9m+H7+2BY8Rvbp76O+mdFZWnZvJhlq4i2pIa4KAeIsjZ75rEQ9pgRW2Y/vEbkTLiDAOaG1+TgSY5KJqh1APkpRoFqTSUrhieFOFdXcNv9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Christoph,
> Well, for that a proper formatted mail really helps.

Yeah for the first main I used Outlook to send, the second email with patch=
 was sent directly using GIT so should be formatted well.
Sorry I am beginner here.

> And these identifiers do not belong into xattr.h.  They are a non-sanctio=
ned NFS side API, not a VFS API.

Ah yes, I forgot about VFS, true. What is the best place to keep them then?
Or is it a big issue to extend VFS with them?
I mean NFSv4 - style ACLs are IMHO even better than Posix ACLs - if not for=
 anything else then because Posix ACLs have never been ratified - maybe we'=
ll see them on local FS at some stage, too.

Thanks,
Ondrej

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: pond=ECl=ED 31. =F8=EDjna 2022 9:03
To: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc: linux-kernel@vger.kernel.org; linux-nfs@vger.kernel.org; trond.myklebus=
t@hammerspace.com; anna@kernel.org; Chuck Lever III <chuck.lever@oracle.com=
>
Subject: Re: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h

On Thu, Oct 27, 2022 at 07:43:58AM +0000, Ondrej Valousek wrote:
> Hi kernel maintainers,
>=20
> Please help to submit the following patch into kernel

Well, for that a proper formatted mail really helps.

And these identifiers do not belong into xattr.h.  They are a non-sanctione=
d NFS side API, not a VFS API.

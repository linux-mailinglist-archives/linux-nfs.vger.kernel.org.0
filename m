Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00EE486652
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiAFOwo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 09:52:44 -0500
Received: from mail-os0jpn01on2104.outbound.protection.outlook.com ([40.107.113.104]:30838
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237811AbiAFOwn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jan 2022 09:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJcnx5A+C6OiVB/aXcPb/ZMPMIFYtSXHG0ETdVyHUOc=;
 b=mzHI+3XQAg7/xoR3ICWJRcokPbWGwZo00HTvZKMDrvhta+dzn/Uf3MbEGF7dJUIfQ2SAnabRDlQ5Z5XKnPorVCecc2AeHbnC16A1rVu1Vjt/qT1/E1WihAnw8351vNymGYzixx+oVC3ZqPUtLPq/RyXXZp/aJ/+hdeXtd6XVpjE=
Received: from OSBPR01CA0112.jpnprd01.prod.outlook.com (2603:1096:604:71::28)
 by TYAPR01MB3007.jpnprd01.prod.outlook.com (2603:1096:404:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 14:52:40 +0000
Received: from OS0JPN01FT016.eop-JPN01.prod.protection.outlook.com
 (2603:1096:604:71:cafe::84) by OSBPR01CA0112.outlook.office365.com
 (2603:1096:604:71::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 14:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 OS0JPN01FT016.mail.protection.outlook.com (10.13.140.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.10 via Frontend Transport; Thu, 6 Jan 2022 14:52:39 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.53) by
 AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Thu, 6 Jan 2022 14:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGtU+fTdTPQDopz4Wg1KvApKbmBXagyjwZj6K9njko+aXR8+CLap5MMpc609DbXLdMt0xj6Ce0qx7cES+uC1yOaQpnOsyNluew4bktgdrhmQNax+Yy2lZTXVoSc9vt6pUViZqUiT6a+omaEYEA4U4f9suwwsd+iX8n/GgAh70TrkCwUWYQtO/2z+ieKDdTQpcCcLgQ7JFTQf0KVrFVryELsRHGnsvMvwiI8lLNM8U5VQUsPsSA2uxnM/Ir/FfpWvp07t9MDpzXRSX4V1vg0XdcbR68sUMX0B9c5JtXKWOECvvINsr3B3f385Wm6wfUUTWCKgu7p75yfHIE6LKZQlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJcnx5A+C6OiVB/aXcPb/ZMPMIFYtSXHG0ETdVyHUOc=;
 b=VV3iATckmBMGhdFeGJ/C/c9OWZjAbW3fg0FkWgS1ZLocgEgTjDXe1svs5HHbCIe2P7A2AKwqTkEUNx9W5SgPm/1ItBHGR1xrBcih/ToZnYkP5H6hYVapLShtmb21guWWeCBjcRPJIYwSq3gT6GNMXB1+vVAjqVwG8ID0cp+wDOXLkrFMMOgU2eMTPAHltgVU7InCb9Yq+wTP7k/1mYaehOKu1LpXQWvyfUn8kVGthcDca6/ImqsFS3bNPjOmXZXF9Kh2c2J8ZFV2al8p5hazV8762Qr7mOb2RzNVphwHRIehwDLC/KEyLGuPzQzYB4+8t7orfAi/ONbGDmPboEimIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJcnx5A+C6OiVB/aXcPb/ZMPMIFYtSXHG0ETdVyHUOc=;
 b=H8iqCtD3DF0XiJ+sqB1P62zDcgMEv4N3s97qicV83D3iQomIT91nyhg3ZENPcXIJr5oZA5NJOM+pHC4w+xwZXEhBEHJ/rRwOFJhHrR5iOoToazjD3hwCZn08YlMe48L18u8CNdz8eb0ie+jiVj/feRGB4JQlHSzBpObMG6k408I=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DB9PR10MB5162.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:330::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 14:52:36 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 14:52:36 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRCAAASbAIAABaVAgAAG2oCAASYa0IAAUGUAgAAAUPCAAANQAIAAAjSAgAAC6CA=
Date:   Thu, 6 Jan 2022 14:52:36 +0000
Message-ID: <DU2PR10MB509689410AAC9E0B9D629558E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105155451.GA25384@fieldses.org>
 <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
 <DU2PR10MB50969D4D096DB99EEC6D1C45E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106142812.GC7105@fieldses.org> <20220106143605.GD7105@fieldses.org>
In-Reply-To: <20220106143605.GD7105@fieldses.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: a7eda57b-1322-4f42-7770-08d9d1242fea
x-ms-traffictypediagnostic: DB9PR10MB5162:EE_|OS0JPN01FT016:EE_|TYAPR01MB3007:EE_
X-Microsoft-Antispam-PRVS: <TYAPR01MB3007B3DB084B9160366C5639D94C9@TYAPR01MB3007.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: L39SGFPQXOP8kbuDL/AYuYPC2ZFdZQVE/P+ybVmB2v4vjjQxCtGd/XXJQDleF05nQypxgm/OrFQX2k7+WbM5/5aeN5wmqjqatFV0Q+eA7L9OTZ1y4cyBXVYeYyaA/bTrLcU+kCsMfagxGl4avZ+LJVc7KfLFejlZhcD7Y/tSRWqTsEWQRj/4OTx/Ujf5+RXte40CBpn0QFLWUNiCkCanUbpGniyNbm8rli7+hO+WV2JGDCXX0wWl41iRJgO65HVdkVdZHAfHEkPiNRerHZ5DvDH3VW8saFrediCoDafkmOUljucBJwSTCe3T3LeulUC0WAYF1ykFMPu3pgMimKO+56hT+k6prZ1dCnC2hCl+TfwZc3O+8SfBQLnSCTco7zJIQl9xPM+I1d2dAkuayijfJYMYIc396A7fsHEZyjwt6y2/5THrqI79uuVqsHk6bs2I05Cj8mG9dr9+OnTchmBZJ8gXzVewGdUPYqMZeE0cAJjwdSpOpoiLka/Mhgfyz+kgc8CwFFiPUritmnYsjCnBDtX3zC56mgdK8HKzeW4DSD1wEnnRIE8/cUr/ZxtCelx0UweL109xWlpJZ2rkZtyMSE9Fiu7FbLT0fCZizaUTgAUBJB8Bt+3hSAw0mD5ktH+uu0Mu8wuA0vJXQ3LnBh6KTPSaKqNn4kwi94ugml4nMVHMlEnW3GGQzbZtHjPQGaCZy6I6Bnz2kqUKDmDriN05Eg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(54906003)(2906002)(76116006)(53546011)(8676002)(110136005)(9686003)(52536014)(55236004)(26005)(6506007)(5660300002)(66446008)(122000001)(71200400001)(66946007)(38100700002)(186003)(33656002)(83380400001)(55016003)(4326008)(508600001)(316002)(66556008)(64756008)(7696005)(66476007)(38070700005)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5162
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: OS0JPN01FT016.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b6f1dcc2-1ff3-45ce-916d-08d9d1242dd8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr,ExtFwd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3puZ/uXsVw1vPy3ib5vJqPmXR2e1ZWuHG7lx07HXGx+a/CgcRo8a311tHi5dOlW2VvWXfRLAPcvSUC5WnONh+i+Ntnl+EKNbVT2dpPbY8GNt5VJUCsIzt4+HdHsvokMJOcuhaAAbs9RMJ8BpXjA6V5nZK0alax8Y3Cn+aTp1D9wNIr0xSKfJ8kdEpT5CGlfhBj3JJYitIr0cBEXM3wGPjGdL+JY1XdfjgmSIZd3e/74zieuS+NmESr+1ZpF+tYwCBz3Mb9JV0v4EC/WBDBc32OtX6xVpxxfK5e+/WZdaOfx6noKKEQbRDnhzZPFBnqUuFvsScFPdH1ZYUCXnspXMKx4xz/6pwfnSxEr3siA3vpvzfmEJGIGiBnm46HCsK4ew0CVdUeZFO/UqxkNygritpHZILbZ1VPZpU36T7AbGajuW3/vSgGob5otE6IGC+dCWYgmyQ0z50qet3CvelvP1cJsde1x4O6tOvCgeR4ek4mP46CgznjCsZ8iu85OAmH0glfxQkdAg6LqtnxPtaVrYPLel+pUrChYpNLpGL5N0GY+V9siVMWcALHmfVGOgadg7ittJSmsq8fTloBr3XIao1+gltQ8UpitH8v6UcpbBWFgWYjHmsPPmWnga8vZRln7DAMXhb0u6TSR/guY5VRQDGAUNFMdQUtbwmmewY+dYeRYzdL2LLfi/YT6raNrPo3DxEPjR9zne9Mnqw9L2z9iTTviKXEb4iq7Ky5oS89wBQZXLPHQ8i8WVdHU/qS2uToOwM1ndkz5I8YNFNWS31m2YpZ9Gt7Xwnjec+c1sQUtPT7Q=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(110136005)(2906002)(70206006)(8936002)(83380400001)(86362001)(6506007)(9686003)(186003)(53546011)(316002)(8676002)(36906005)(26005)(7696005)(47076005)(4326008)(70586007)(82310400004)(52536014)(33656002)(5660300002)(55016003)(40460700001)(508600001)(81166007)(36860700001)(54906003)(336012)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:52:39.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eda57b-1322-4f42-7770-08d9d1242fea
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: OS0JPN01FT016.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3007
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

You rather mean bmval1 not bmval0, right?

-----Original Message-----
From: bfields@fieldses.org <bfields@fieldses.org>
Sent: =E8tvrtek 6. ledna 2022 15:36
To: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>; linux-nfs@vger.kernel.org; a=
nna.schumaker@netapp.com; trondmy@kernel.org
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes

On Thu, Jan 06, 2022 at 09:28:12AM -0500, bfields@fieldses.org wrote:
> On Thu, Jan 06, 2022 at 02:19:22PM +0000, Ondrej Valousek wrote:
> > > You also need to update the value of NFSD4_SUPPORTED_ATTRS_WORD1 to r=
eflect the new support for FATTR4_WORD1_TIME_CREATE.
> >
> > Yes, I realized that one shortly after I sent the mail.
> > Just going to try this patch:
>
> Thanks!
>
> Don't we want to vary support depending on the filesystem, though?  Is
> there a way to query that?

Poking around a bit...  looks like we need to check stat->result_mask & STA=
TX_BTIME.  And use that to adjust the value of bmval0 at the top of encode_=
fattr, and make the below encoding conditional on it.

?

--b.

>
> --b.
>
> >
> > [ondrejv@skynet19 /opt/kernel/linux-git/fs/nfsd]$ git diff diff
> > --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c index
> > 5a93a5db4fb0..be47e1dd6da5 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3265,6 +3265,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struc=
t svc_fh *fhp,
> >                 p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
> >                 *p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
> >         }
> > +       /* support for btime here */
> > +        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> > +                p =3D xdr_reserve_space(xdr, 12);
> > +                if (!p)
> > +                        goto out_resource;
> > +                p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> > +                *p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> > +        }
> >         if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
> >                 struct kstat parent_stat;
> >                 u64 ino =3D stat.ino;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h index
> > 498e5a489826..5ef056ce7591 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -364,7 +364,7 @@ void                nfsd_lockd_shutdown(void);
> >   | FATTR4_WORD1_OWNER          | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WO=
RD1_RAWDEV           \
> >   | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_W=
ORD1_SPACE_TOTAL      \
> >   | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_W=
ORD1_TIME_ACCESS_SET  \
> > - | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
> > + | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA   | FATTR4_W=
ORD1_TIME_CREATE      \
> >   | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR=
4_WORD1_MOUNTED_ON_FILEID)
> >
> >  #define NFSD4_SUPPORTED_ATTRS_WORD2 0
> >
> >
> > ... will see
> >
> > Legal Disclaimer: This e-mail communication (and any attachment/s) is c=
onfidential and contains proprietary information, some or all of which may =
be legally privileged. It is intended solely for the use of the individual =
or entity to which it is addressed. Access to this email by anyone else is =
unauthorized. If you are not the intended recipient, any disclosure, copyin=
g, distribution or any action taken or omitted to be taken in reliance on i=
t, is prohibited and may be unlawful.
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.

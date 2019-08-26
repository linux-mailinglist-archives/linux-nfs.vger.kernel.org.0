Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8989D4E1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfHZRZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 26 Aug 2019 13:25:09 -0400
Received: from smtppost.atos.net ([193.56.114.176]:26526 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfHZRZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:25:09 -0400
Received: from mail1-ext.my-it-solutions.net (mail1-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 7f4e_2c99_af26b840_631e_4528_b908_df7607ae1b4b;
        Mon, 26 Aug 2019 19:25:05 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail1-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QHP5dI006401
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 19:25:05 +0200
Received: from DEERLM99ETQMSX.ww931.my-it-solutions.net ([10.86.142.102])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QHP5KE001130
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 19:25:05 +0200
Received: from DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) by
 DEERLM99ETQMSX.ww931.my-it-solutions.net (10.86.142.102) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 19:25:05 +0200
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 19:25:04 +0200
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 26 Aug 2019 19:25:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr09ATM0Q8GW970HCwHNbt4RpA7R+vfa6eCXG9/ffP8oIIkE0q1nYK9Wh78lSLjVKFkcwKBgLaq639hK8Q+Majv8CEqnxqyYyHf/afJ4gWaxZiQ750hP4DXPkIFOjoGqtFEXJmPvWv1szdJPZg/FqNQ7WGKUq76SnN2/CGH/jbrrpJCtrVQPapr1XrMX4EO26Yvx88DH9f8c/3bW46gwNEnHV+/vgwPUKI4sV6oF15EP9QYeQ3TPE4at2/BdmTxpe4pKwA/2HYCfdzdD+J2Ih4Gbs6OqZAMjPN/ESF1nb/vweCi25ihOYjLE0O9LKBp+SosKC6+Vi0OflVb4nWCFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp+eF9Rut42JixlBn6ZzmlhW75E9+9kY7daGAPPkqno=;
 b=QSlpaqT03wPCzZr0y30OqqLwVliCN/dMheDJoGhGGqQ8+BHNY9A/C14OUkDncyRPX9+avWgZ+r3nZbvE67VGdben2BopfZT31I/PKAzXomffVHKanpMle7IJQ9klwUNw5QCaQsTiSclEJ4/POZxFmuTRN4Y95aFW0ekVJIIqgQu1T7Zri8/1/A04NnnTgY8kmp0yewGd/5zec2tFmeyAVruWjOaoVhMjgi+u1mgCUw4szY5yJb4eIo8CzIPc2Ddjw/eezrOJd2c5bT4WbJINWm/nogLhq+RTjcrHuCUs5mKEG54LzjX+jNrRa9qE3Ter1kvbl+vlhYWLZLSL4CJWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (10.173.88.135) by
 AM5PR0202MB2481.eurprd02.prod.outlook.com (10.173.89.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 17:25:02 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea%12]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 17:25:02 +0000
From:   "de Vandiere, Louis" <louis.devandiere@atos.net>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpwAISMAoAAAgBdYAAEV7cAAADj6cA=
Date:   Mon, 26 Aug 2019 17:25:02 +0000
Message-ID: <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
 <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270>
In-Reply-To: <20190826164600.GD28580@ndevos-x270>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=louis.devandiere@atos.net; 
x-originating-ip: [67.222.209.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73fa07e1-e96a-4d1e-fae3-08d72a4a5421
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0202MB2481;
x-ms-traffictypediagnostic: AM5PR0202MB2481:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM5PR0202MB2481E49126D0F8A80A6BC4BBE7A10@AM5PR0202MB2481.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(13464003)(42274003)(40764003)(966005)(256004)(478600001)(316002)(45080400002)(66574012)(9686003)(26005)(99286004)(476003)(7696005)(102836004)(76176011)(6506007)(53546011)(66066001)(55016002)(76116006)(186003)(5640700003)(6436002)(486006)(229853002)(66946007)(66476007)(66446008)(64756008)(2351001)(66556008)(6916009)(2906002)(86362001)(71200400001)(71190400001)(2501003)(52536014)(33656002)(53936002)(6306002)(25786009)(11346002)(446003)(3846002)(6116002)(74316002)(305945005)(14454004)(81156014)(6246003)(14444005)(81166006)(5660300002)(7736002)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0202MB2481;H:AM5PR0202MB2564.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oc4l3Oe5ggPOnEl3YTH0j3DbrKVh4uu41T80E0Gy3HiJc0vlUjmMyEq8tC6IimAD3f4GoDC9woaynKvelmkNKO/+ZeIL7Fv/rKjyS+ptnjjZdmrdlg6ZD1JASLZfePkcPYISrEGbh/jb0QRl8zgXMloK8cZhHIUEwV0055qc0GfafbL6EndnxKQu91/NBZoeotL/cdNVYSikDGhiB8g54MLvcIH9KgMtiP+wP0MARKmiJoeBl6js1n7nSXjXNfprUoVnv3tEJv14z0SL90T+SVDNonrY1kd4XTCtfVvpt2oj5f4wFzlWIMOrPGhUDiwMZHVSEGDegLVjv4As/JHrz2kWXSH4NF4CCqCZ9Md/d8qGB+gzHbPQA0FyJMdD1HIJ0xi9gdSV2+3j4CK7SAEQmPk5XDCbo9JewodzbCuWnhY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa07e1-e96a-4d1e-fae3-08d72a4a5421
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 17:25:02.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /32Y7E9FLuZrdCE8z0+LxPdZXk8mkXMS/02Zyx/w1MQ0vqXUMP1oSHIxI+HsgywV2ecv9Wkvc+xZtefe71rB4iZzu/q9oddD7J44rFziBYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0202MB2481
X-OriginatorOrg: atos.net
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Niels, I tried your suggestion. According to the documentation (https://linux.die.net/man/8/mkfs.xfs), the maximum size for the inode is 2048 byte. So I set it to this value, and faced the exact same limitation. On the other hand, when I used setfacl -m on the XFS mounted disk, I did not face any limitation and I was able to set thousands of ACLs on a single file.

When I do a strace, I see two different types of ACL used when the system calls setxattr: system.posix_acl_default and system.nfsv4_acl. I tried to look for hardcoded limits associated with system.nfsv4_acl but I don't have much experience with C and linux kernel.

Thank you for your help.
Best,
Louis de Vandière

-----Original Message-----
From: Niels de Vos <ndevos@redhat.com> 
Sent: Monday, August 26, 2019 11:46 AM
To: de Vandiere, Louis <louis.devandiere@atos.net>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Maximum Number of ACL on NFSv4

On Mon, Aug 26, 2019 at 02:53:05PM +0000, de Vandiere, Louis wrote:
> Yes, I assume it's not very frequent to have hundreds of NFSv4 ACLs. For compliance and organizational issue, we cannot use groups efficiently to manage access to the shares, so it's user-based and case by case.
>  
> My real goal is to be able to replicate some files to a new NFSv4 server while preserving the ACLs. By using "cp -R --preserve=all acl-folder/", I'm able to preserve the ACLs when their number does not exceed 200, above it, I see the "File too large" error while rsync does not work at all (even in version 3.1.3). That's why I'm digging into this and checking what possibly could go wrong.

You might be hitting a limit in the filesystem on the NFS server. The ACLs are stored in extended attributes. Depending on the filesystem, you may be able to configure larger inode sizes (or other storage for xattrs). With XFS this can be done with 'mkfs -t xfs -i size=.. ...',

HTH,
Niels


> 
> Thank you.
> Best,
> Louis de Vandière
> 
> 
> -----Original Message-----
> From: Goetz, Patrick G <pgoetz@math.utexas.edu>
> Sent: Monday, August 26, 2019 8:44 AM
> To: de Vandiere, Louis <louis.devandiere@atos.net>; 
> linux-nfs@vger.kernel.org
> Subject: Re: Maximum Number of ACL on NFSv4
> 
> I'm dying to know what the use case is for this, and why you can't just do this with group permissions (unless you're talking about hundreds of group ACLs).
> 
> On 8/23/19 5:31 PM, de Vandiere, Louis wrote:
> > Hi,
> > 
> > I'm currently trying to apply hundreds of ACLs on file hosted on a NFSv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19.el7.x86_64). It appears that the limit I can apply is 207. After the limit is reached, the command "nfs4_setfacl -a" returned the error "Failed setxattr operation: File too large". The same problem happens if I use an ACL with more than 200 line in it. I did a little debugging session but I was not able to come up with an explanation on why I'm facing such an issue.
> > 
> > On the other hand, I can apply hundreds of ACLs on XFS without issue. Do you know if it could be a bug with the nfs4-acl-tools package?
> > Thank you for your support.
> > Best,
> > Louis de Vandière
> >>> This message is from an external sender. Learn more about why this <<
> >>> matters at https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flinks.utexas.edu%2Frtyclf&amp;data=02%7C01%7Clouis.devandiere%40atos.net%7Ce3e196698745444ba59208d72a44ed69%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C0%7C637024347858295832&amp;sdata=peZa9vHRp77QbOX2yTj204oWk8iCO%2FxNbSMzkylf38M%3D&amp;reserved=0.                        <<
> > 

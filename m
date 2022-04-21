Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746A350AC8C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 01:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiDUXzn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Apr 2022 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385942AbiDUXzj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 19:55:39 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2073.outbound.protection.outlook.com [40.107.66.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AC48E68
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 16:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jImjN8MWrksbYUyIkoil6auzkGA1k9IeC72rgHr8BQQbSlzG8j9MPnQPwz05aNl/Wv79tV7mB2fsfp5N6EtnBnavqDbCLycpRItWpP/Y9GFI2T4MY0BahC2bxIO8sBBUP2syN5hniJRZph5BVbrFzvOyFOo43ffdRRGJBi719DnSOd/mVC6BFmoTDUz7SDDBAZWL2Sp/Biz7dCXCsQSH6XJ2051SfJxHvysgVejRCO3v+AOV1sYpfsbP8Lv2ySwWGII+s9iGk5LeETTluEWRa84Qw6r6mPhssvysG7X3lgf7asYWA8UH4pxsAaKtDcTRBcc8mKVSW6cPcXS67cn4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnaNdpt45OSTJ6l8ptJC0QDfruFQXegwS91bFK4qiyc=;
 b=Z2iJSafYhvlK4oC8B1CR53EFOp1RhHI0nNLYAESIBGaRgQ2n3TmV9xdJjdpX8FfpC4aDEjFpwlMofJE1KYC9Q12rMl01OOrLiQK6GB8KSedvK0lOyetgeS2uDG4xM4hSv46mDLREsZDvNIMlpHPbLLTCntcxTQGS9ByLvL8IDKStvErw0YxwpbQyc4ku1l9CXJSF0mqip9gHv99LEPmK5azOILhO5lbqZwQqnrUHJZ04KYdqYWUmkZ+OU1oKReVHmhvGnaoZnqMhTI2tMOyNmq4OHukDJ0yNV44Y6lEQZ+33W8pEXVsO1MXNIdSPHAdCmel0eDudi7ceEv2AeEDNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnaNdpt45OSTJ6l8ptJC0QDfruFQXegwS91bFK4qiyc=;
 b=SGX5ZL2Pwgp/KcLeOh6Z8DVIT1RUWx7YVuld5Tezn9c1agxWZgolttVsLaaHGlHV4w0dAKbTFTGU/Arix+xrJBVuF06fbaEDcKzuP+SvfBHbBdPGh6J/07szeRH2lD98yIR7q2YaBDS5KhfMuAa3QuzaRFGh8cuxwIotLCE/zu2Pbc7QSbu1GH8cZxsdeEu1ysiveXWapbEvSds/XAVqlIQXXMHuqTu00DSzuE/9rKkdVD7FQpm0D5dg9e+o5qlt/MshSgkms3I4Q2VIBzEm0F/fTmtLOOJIlt76wYfsujCaFGg0X9PuJNc40BVZmJGdKn5wSelBGp9tZLAqYLmGtQ==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YT3PR01MB6163.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 23:52:32 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:52:32 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "crispyduck@outlook.at" <crispyduck@outlook.at>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrA==
Date:   Thu, 21 Apr 2022 23:52:32 +0000
Message-ID: <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
In-Reply-To: <20220421185423.GD18620@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 326acbec-3742-3066-17d0-7521807b64d1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d0a120a-d7db-431e-375a-08da23f20080
x-ms-traffictypediagnostic: YT3PR01MB6163:EE_
x-microsoft-antispam-prvs: <YT3PR01MB6163594DF0A1CCBF5DFF1250DDF49@YT3PR01MB6163.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trHBqbA56HvyE5Y4YTG1IeYWrOz6EmTzsNpNyLjPckDvY5hyDID1ZCkR6klWiRuLhxNbanB5PsMmxwT+udMEMmSJ0wfj7aumikbwCDgs7p4VNdqeaIZbNghvqPDIB5kaGTcSlwGYdBgSi7kyoUKTH2f+3ZSQd3Qj5EOGc+aUZfxA0AgJgjqHK5PfPZz+LD6WkHUCHtG88khY8YQjHOFjGOduZVzeeIgwDMFmEnn8DuHQHnAoh9/WYFq4+Yn1TPJUx91oC5mtDMf5j+01H8169tQD0Z5Cld+k5Q5N50bwmepkFcBPxeJWxr2IhlmgF+KvuN1jIZLVmgkPMo8Di7GkX+1wY6hdnDhuoBI0atOZQVxD/oU2Bd4gioAO4Dac9Zz6wY5LiNIgSRmngSeiShd4BV0PyF03HRWWkhCifEI7w0MFLIDAmZN0TJ01qrrKtj0/rU4XhCUfC4a/xRTofSzSfRS969DRzeHLWl4RptboO8cpj400v+mtZ7Wlf+UDZLbTWTLKyxtZWwaxcjSEhZ0GhCZ9Ur2X2q2tvoDdsd2/O84soDDVzcc89QfinfIldrsO9L4GWEebM/FjdGhjsxp3P2lGbeO8Oa5yI63JkeUxvwsueqV0IEsZuQeawiLe3GSU7Swz/VQvykUuhdIGEd8RhP8u3gv+qQQlxMUfBD6cXO0D3ifT6L+WpDJIZYSt2ErjoDJo2/7jh8DcIDG3ZiKRnv10+BBtN4PaZv8LyCYZHnFArzRFIxs0R4YS7X8by/g6yZOqD4lpCIRaUDmAHcpq6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(7696005)(26005)(186003)(86362001)(8936002)(53546011)(38070700005)(9686003)(38100700002)(122000001)(4326008)(8676002)(33656002)(52536014)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(55016003)(5660300002)(2906002)(316002)(786003)(71200400001)(54906003)(110136005)(19627235002)(966005)(508600001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?72Qfn8hUJPH1Gr+ZaLyTh+0DLhjO/q52SXY24ACgXyEYn0beQqvMA56FUk?=
 =?iso-8859-1?Q?lCRACXsahCa+doRNb0frb7I3FrhRuF3t5K6Hd0u4FNQ5S9OSYxadqQO3BO?=
 =?iso-8859-1?Q?fQ+fimOLziE+0X4fb+6ZdwEKkQ2vahI3jh7H6k+m74HSy5aYhFeXzfpC4P?=
 =?iso-8859-1?Q?a4bZ2H2H2F/VL3sKkq5MCoUVlBfg83oQaO3wBjTAAwPh8DHS7vyw6Ble3Q?=
 =?iso-8859-1?Q?IBRxnJMGiqskaz6cT09K1M8IDldWwsyiYjJd+ZUNepfWVjci/5nv+TAx+Z?=
 =?iso-8859-1?Q?L7/hYkzpshbPF5vwy9vYblcSao0FSomCv1KLmktik7lmiLJStlgXHm6RVX?=
 =?iso-8859-1?Q?uPRsFVgNQxZQ+mnNUkeWqS1bz0WGj7gp35lLGKztHLVh9kIxuWrnetjK1H?=
 =?iso-8859-1?Q?i24uAHFFAX09nDm6/yE/m85YjGnkKujDZtKxaDIFdNTRcz0HQmne+Xmkc1?=
 =?iso-8859-1?Q?eWIPFnP71Elu3hvWvTqqdSBP6Mvw9FR0kIkeAPYrecf3P0lENepkzCLH8f?=
 =?iso-8859-1?Q?HlARwcaVNAhrx6rDxKt2n0Q9H5NaIKTLF4mCQtBVttLhCdcKWfwJ80W+PV?=
 =?iso-8859-1?Q?/cAyq9lzV4gbcj60LbeTuCq3eFOA/Zc2kHpQWNkZY7oOfETsDhg6oXezHg?=
 =?iso-8859-1?Q?HgqIlkcDTKDP/zMtz1rmp/0s0VdngP/jnQtKp+P6/BOyKCInqorxacw71E?=
 =?iso-8859-1?Q?LVvTxUmhg/+plBeMXDUiJiL0lE1bIX509F8igabfyKs4G+N1f/4hj/s36Q?=
 =?iso-8859-1?Q?2pK+kGAb5fX5gKkAbLubi2dWvEke+oDTYCacPkRWCov2mIb3nOrRZ31MWB?=
 =?iso-8859-1?Q?tGYzwqaJpoM/S2mjFUKElBUDye9s6cvwBT/NXe1CYcIu0DK6O+AeaONahg?=
 =?iso-8859-1?Q?pzCPJklLMJ1+vPTTaO5dxnmWoPQOTR3NfBd3u8EppUar868LOubqf/TxU4?=
 =?iso-8859-1?Q?NxCus7dZTP4NOo09d/K/9jtL0jPlzD6KJGY9vuCdmpOCrMgw9vA0hzJSjS?=
 =?iso-8859-1?Q?7w3YNyImZmM3Wb5m+7T37782VXAsYdjlql2gXcfT4z5kRfXrS/ETxl7DH2?=
 =?iso-8859-1?Q?YNolGDRNtp2F1Ml0M3YvPNxSMg2sWAu8D2/oxkcvbO72DJNpwbTIWhTDq/?=
 =?iso-8859-1?Q?MkuJQHRA38ylm+pFXMWs6TuZeVfwNsQO5IYG9LzeiyQ5LjXY78UXW/8hpZ?=
 =?iso-8859-1?Q?zOmfrLQP+YH9H8nh2zq/D0/fFkvtU5pgg8Kgw724T0nzsO9KXXL3D/65np?=
 =?iso-8859-1?Q?rfl2bhTHD69PYDWe350jRYt7PEJAcKN9heteOH7P5Cd/qFgj5HRg8H3aYX?=
 =?iso-8859-1?Q?Obryg4w6yhoQIOv/i7c8QuOke8DJtgunLVHsGtchF5WQHlMmRslXhGg0xL?=
 =?iso-8859-1?Q?FNaDm1q6VEzg47JJtIe57NGkMyTy1QE0XUogB3eX+8HFdX29XGzG9r5p4G?=
 =?iso-8859-1?Q?+wsXACjpBBn/yt4wT6SWZeO6xtBTeVmGj6XexYCRW8ckMRO2grfWgVoCNx?=
 =?iso-8859-1?Q?mHYP0J4QFXMcGuluD0CDWIjx9TZqTl6U3OTz6lxUnwGAU92KSjmY4O+/Uu?=
 =?iso-8859-1?Q?zvpF7tA15hWap+ZwSVHmudhroCUfbtn88OuEBNkMSJVYAurOtwEuzVs8e2?=
 =?iso-8859-1?Q?mqh9XAT1ESZVLmfMeBthlB4cxS9a25NAq9mlYHrokcAfK+/cYhOly2843o?=
 =?iso-8859-1?Q?YmZ+BoVRXNEs9ojxOuSc6fUSCp9lfPVZWipIG1XWiEaR1CPTtoizMr0NVN?=
 =?iso-8859-1?Q?9V1U+NR7AfzwMzRcikR8TvSIc+7auFJSGCC0Z54eW2SGxF30MlW0hSPNis?=
 =?iso-8859-1?Q?A5RqAUFOSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0a120a-d7db-431e-375a-08da23f20080
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 23:52:32.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9H84xKAtsHPP3pM1XZrE1YqMbTp+08yBG1XuY1ydLTyi80PlyCBrhNSNHs4tg9nkfW0WGFoEgfO5mkxjp0zUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6163
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:=0A=
[stuff snipped]=0A=
> On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:=0A=
> >=0A=
> >=0A=
> > Stale filehandles aren't normal, and suggest some bug or=0A=
> > misconfiguration on the server side, either in NFS or the exported=0A=
> > filesystem.=0A=
> =0A=
> Actually, I should take that back: if one client removes files while a=0A=
> second client is using them, it'd be normal for applications on that=0A=
> second client to see ESTALE.=0A=
I took a look at crispyduck's packet trace and here's what I saw:=0A=
Packet#=0A=
48 Lookup of test-ovf.vmx=0A=
49 NFS_OK FH is 0x7c9ce14b (the hash)=0A=
...=0A=
51 Open Claim_FH fo 0x7c9ce14b=0A=
52 NFS_OK Open Stateid 0x35be=0A=
...=0A=
138 Rename test-ovf.vmx~ to test-ovf.vmx=0A=
139 NFS_OK=0A=
...=0A=
141 Close with PutFH 0x7c9ce14b=0A=
142 NFS4ERR_STALE for the PutFH=0A=
=0A=
So, it seems that the Rename will delete the file (names another file to th=
e=0A=
same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,=0A=
because the file for the FH has been deleted.=0A=
=0A=
Looks like yet another ESXi client bug to me?=0A=
(I've seen assorted other ones, but not this one. I have no idea how this=
=0A=
 might work on a FreeBSD server. I can only assume the RPC sequence=0A=
 ends up different for FreeBSD for some reason? Maybe the Close gets=0A=
 processed before the Rename? I didn't look at the Sequence args for=0A=
 these RPCs to see if they use different slots.)=0A=
=0A=
=0A=
> So it might be interesting to know what actually happens when VM=0A=
> templates are imported.=0A=
If you look at the packet trace, somewhat weird, like most things for this=
=0A=
client. It does a Lookup of the same file name over and over again, for=0A=
example.=0A=
=0A=
> I suppose you could also try NFSv4.0 or try varying kernel versions to=0A=
> try to narrow down the problem.=0A=
I think it only does NFSv4.1.=0A=
I've tried to contact the VMware engineers, but never had any luck.=0A=
I wish they'd show up at a bakeathon, but...=0A=
=0A=
> No easy ideas off the top of my head, sorry.=0A=
I once posted a list of problems I had found with ESXi 6.5 to a FreeBSD=0A=
mailing list and someone who worked for VMware cut/pasted it into their=0A=
problem database.  They responded to him with "might be fixed in a future=
=0A=
release" and, indeed, they were fixed in ESXi 6.7, so if you can get this t=
o=0A=
them, they might fix it?=0A=
=0A=
rick=0A=
=0A=
--b.=0A=
=0A=
> Figuring out more than that would require more=0A=
> investigation.=0A=
>=0A=
> --b.=0A=
>=0A=
> >=0A=
> > Br,=0A=
> > Andi=0A=
> >=0A=
> >=0A=
> >=0A=
> >=0A=
> >=0A=
> >=0A=
> > Von: Chuck Lever III <chuck.lever@oracle.com>=0A=
> > Gesendet: Donnerstag, 21. April 2022 16:58=0A=
> > An: Andreas Nagy <crispyduck@outlook.at>=0A=
> > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
> > Betreff: Re: Problems with NFS4.1 on ESXi=0A=
> >=0A=
> > Hi Andreas-=0A=
> >=0A=
> > > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wr=
ote:=0A=
> > >=0A=
> > > Hi,=0A=
> > >=0A=
> > > I hope this mailing list is the right place to discuss some problems =
with nfs4.1.=0A=
> >=0A=
> > Well, yes and no. This is an upstream developer mailing list,=0A=
> > not really for user support.=0A=
> >=0A=
> > You seem to be asking about products that are currently supported,=0A=
> > and I'm not sure if the Debian kernel is stock upstream 5.13 or=0A=
> > something else. ZFS is not an upstream Linux filesystem and the=0A=
> > ESXi NFS client is something we have little to no experience with.=0A=
> >=0A=
> > I recommend contacting the support desk for your products. If=0A=
> > they find a specific problem with the Linux NFS server's=0A=
> > implementation of the NFSv4.1 protocol, then come back here.=0A=
> >=0A=
> >=0A=
> > > Switching from FreeBSD host as NFS server to a Proxmox environment al=
so serving NFS I see some strange issues in combination with VMWare ESXi.=
=0A=
> > >=0A=
> > > After first thinking it works fine, I started to realize that there a=
re problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).=
=0A=
> > >=0A=
> > > Importing ESXi OVF VM Templates fails nearly every time with a ESXi e=
rror message "postNFCData failed: Not Found". With NFS3 it is working fine.=
=0A=
> > >=0A=
> > > NFS server is running on a Proxmox host:=0A=
> > >=0A=
> > >=A0 root@sepp-sto-01:~# hostnamectl=0A=
> > >=A0 Static hostname: sepp-sto-01=0A=
> > >=A0 Icon name: computer-server=0A=
> > >=A0 Chassis: server=0A=
> > >=A0 Machine ID: 028da2386e514db19a3793d876fadf12=0A=
> > >=A0 Boot ID: c5130c8524c64bc38994f6cdd170d9fd=0A=
> > >=A0 Operating System: Debian GNU/Linux 11 (bullseye)=0A=
> > >=A0 Kernel: Linux 5.13.19-4-pve=0A=
> > >=A0 Architecture: x86-64=0A=
> > >=0A=
> > >=0A=
> > > File system is ZFS, but also tried it with others and it is the same =
behaivour.=0A=
> > >=0A=
> > >=0A=
> > > ESXi version 7.2U3=0A=
> > >=0A=
> > > ESXi vmkernel.log:=0A=
> > > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompli=
ance:209: [nsx@6876 comp=3D"nsx-esx" subcomp=3D"vswitch"]client vmk1 reques=
ted promiscuous mode on port 0x4000010, disallowed by vswitch policy=0A=
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)World: 12075: V=
C opID esxui-d6ab-f678 maps to vmkernel opID 936118c3=0A=
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41:=
 NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed:=
 Stale file handle=0A=
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41:=
 NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle=0A=
> > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: =
NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: =
Stale file handle=0A=
> > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: =
NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle=0A=
> > > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD=
 page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported=0A=
> > > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path e=
valuation for device mpx.vmhba32:C0:T0:L0=0A=
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)World: 12075: VC=
 opID esxui-6787-f694 maps to vmkernel opID 9529ace7=0A=
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-0000=
00000000/test-ovf/test-ovf.vmx=0A=
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: =
Creating crypto hash=0A=
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-6978=
82ed-0000-000000000000/test-ovf/test-ovf.vmx=0A=
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-0000=
00000000/test-ovf/test-ovf.vmx=0A=
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: =
Creating crypto hash=0A=
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-6978=
82ed-0000-000000000000/test-ovf/test-ovf.vmx=0A=
> > >=0A=
> > > tcpdump taken on the esxi with filter on the nfs server ip is attache=
d here:=0A=
> > > https://easyupload.io/xvtpt1=0A=
> > >=0A=
> > > I tried to analyze, but have no idea what exactly the problem is. May=
be it is some issue with the VMWare implementation?=0A=
> > > Would be nice if someone with better NFS knowledge could have a look =
on the traces.=0A=
> > >=0A=
> > > Best regards,=0A=
> > > cd=0A=
> >=0A=
> > --=0A=
> > Chuck Lever=0A=
> >=0A=

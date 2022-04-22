Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665250C4B2
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Apr 2022 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiDVXWv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiDVXWo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 19:22:44 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2062.outbound.protection.outlook.com [40.107.115.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDF1E1764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 15:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWpwAkFJDhSubG2j7cMBTJCXh+UXHjmtO7kUowEg1ZAzIZlzmZBNrCIJPjHpwuXr7HSPRbS0ZQyHDPf68v0LhqRdkq9zJXkouraKbO/ePNouvmf5ewJ1COEQ+EmuDEdUOPpBI1FtVaiPG04SJozY5wew9FhrCaQBKYpbuB3TpzZEUXMSgV8ZZcsBgfxlhn4ieji+FOwjLQei4t/4YrvczxG5YwmbsqAftVKYj5CqPOCEUgeSgLdy1+uXcVqsGRBYEVsg8PvQ1L8qoKEWRIhVS17LzootCMPpG7OuytwOFkNG566lVmentSnbRT7wswLoNdJV1WZgwWsn/rF5PkB3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSyr2apoXUyijUjizTGoAC5enGdt2pWRBTp/4VSosz8=;
 b=kCDKl0dLlPBJkOJB+ok181c/A3t+XWeDnmrQxXsO6eZp3T56v8xpPyaQvVXfxLssoHlYjH3s9eLH2V2um4tRiUDsdn4i3BwhK4JWbL5OFCJeb911a9lqbKzcTpWTPhCu2hwFd/KgjGS9jgqdYg8ft53pihfDDqHbAsn7LhNXH/3RT/yr52v+LcKc63pq0P6XZ0JnK+aBAhy8odS56uWaPuwzRC3g7fXumhnGE452UGI95khRjWfMGbTeBT6m+PmvGPmVEA4IelVJyKUqA93/NveD5jREIjiZAPncX8vkIRbAnWaNYJIKaXJhEcGwGewUK2SUdU1Qo8OdcFKNP/pJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSyr2apoXUyijUjizTGoAC5enGdt2pWRBTp/4VSosz8=;
 b=GqWSTspC409OtVxGJ3ICotqgMG+BGUeRKvotwsndypo/i1xLR9DRuDjG3ljPYvFBIyO4OeHuGq38Ybil9J/ZsfRbLDOmDHie0Y5Vb4ja0se7E2RPevodQUU/yJXj3UzSpws+2ysT2dAfHSfE1RYBC9Y0RzUE4VFvm2mgtRifGO70egqY+4EuK7Kc4k0P1fPd+zCLGwipKtpySd5JNGAsHVN6xdwH0AmgMpmoYYNOcyCP0ssHSJRQBin1BKKJZl6VJ3S0RGftldQOKc2l/FLl1rzE+4BPGwdj9sp1v0LtQHNmcZSwwCOwzwCuK5Kz7HakyrgVwZFJ3vbhwNg/mf7YQg==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YT2PR01MB6595.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:58:10 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:58:10 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIAA+egAgACKr4I=
Date:   Fri, 22 Apr 2022 22:58:10 +0000
Message-ID: <YT2PR01MB97303F9E6AE14BE4D489F9BEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
In-Reply-To: <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: faa94470-62a9-8e11-bc90-48603b376322
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bf7427e-14c9-4485-9b51-08da24b392e6
x-ms-traffictypediagnostic: YT2PR01MB6595:EE_
x-microsoft-antispam-prvs: <YT2PR01MB659541A1B6CE5B2E768CF7A8DDF79@YT2PR01MB6595.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keBNGVKKL8dFuJMnTkwMl3jpp8bYWRVqiJhiQyENseMz5ZSLKUJ1Zt5IYz8bozzQ3CZRA9B8OAFBdoX6CZ9ZK4MGW4nxibqsl8zNVoQDUO3wLYx8ErxkIfbpwqwHoe8HH4N1GOTj04ZNIzfDHGeuNTPINflZRzDbPduvMTxAjyZf95UOdS+bs3htcVxHMalGWFxQZJqsqokmGR77Q9uuppNl1N9k8xtQLQpiGU22iFOl4HgHqf/f9IrtMHDi9B/fsoBT3cChaKsdVnoXJ1TNC2sKxjl3Rz7O6wIA+wA+31s6Qj74QzaaTw5L4rsutZBTN1N/bztpLYQ9P4qbVAif/+YPnOvO669XU75AIF3/Aoy9IZCx0ruxr6xL47Mjz77mCKA06uf0oYE0ZetFgD388q4ryLfbiG0ru8qBo4RhaScCs4bFGAN15zejGbfsI6JfqiZpIdWup/084MEdA7vOdmzVAwWm8z5/eYOdu/eCbeAAWGCkkoEBJ+k7bc1kzStOYpsCnan8wnGH21plKNZ4brDvRwVSzU+C3Giq1fjwSvqGBOCjTSkltJyL2VurXJnmRiQBrLMc08ljnTSY1bnZulz8dR/AfePogFfEPKgHCqS32K3V7MMPdwppUeh5HVp9uoPF8TcRvnuzCz+nRRFvk6DRe3SM4v99c78IZrndqe9aIrRbrgRoJu4tcAlhvMPz5ntnMo8kS4rKl2MnfKiwqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(55016003)(508600001)(66446008)(7696005)(6916009)(38070700005)(38100700002)(83380400001)(122000001)(8936002)(71200400001)(52536014)(186003)(91956017)(5660300002)(2906002)(33656002)(4743002)(8676002)(64756008)(54906003)(4326008)(76116006)(86362001)(66556008)(66946007)(66476007)(9686003)(316002)(786003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7MT+zL4HTm9ZiNWGgP2F0QEuGU4DbzpN2e93Lc3P7go4zsJhVjt/fB9fDF?=
 =?iso-8859-1?Q?EGMdGyPCI2bN4Oj9W55GmTDrYWZsosmyULoaGftucSU5tSQn2KxgfLBrqN?=
 =?iso-8859-1?Q?Zb3h104UoL78C6E61G4idaqD3IEhVfkX/J8pDhNZTu1xhB57N0nyo/60mT?=
 =?iso-8859-1?Q?txDx/K3arXpdEg1OmtpeaZ63DLRP/DJmvLrKfay4kQ3MFQn1PW5kznxazi?=
 =?iso-8859-1?Q?BJUsTZg2uc5RCjPEf8ykAhcCvRvyQN7UYzqKeqENeoTfR+gBF0+u29b912?=
 =?iso-8859-1?Q?QB+sjVZQY5taKR8+USd5kM0tJXCMg3g0g3dX9Svg5RCTl4bHjfOGTl+mOM?=
 =?iso-8859-1?Q?nKfDRHcOWfBh9/b+GCAIisVQdkQZYlwFWZ6QHTgbQ5JZAJx7EhzZ0Ntmj4?=
 =?iso-8859-1?Q?fe9XeG+Jg8NLPhxXDfUYo339h1eZGy9w/3EQqwkqt2+58J6ihA6U6VC3E7?=
 =?iso-8859-1?Q?+uNb1eZUOFQOKphSYrBjZ98wEenQa37fB0eG2MJxFe4fgRT+dZD17ecOgE?=
 =?iso-8859-1?Q?ibYUIUxAKTq9JSllh8Rc/vGNIPrZ+i3dkpUfm3sZ+2ntXSz21bzjQU8mQX?=
 =?iso-8859-1?Q?YjrdtG/ZU1/jpVVRThRfRUu95EvYGV8LtQsvnLuvA31+cSNGwBnKFGRDRA?=
 =?iso-8859-1?Q?fk801pp8gX8IFZ1MxIEUDRT2E4RFvmpptJVt6UESWggyDNNxItbHEtME70?=
 =?iso-8859-1?Q?nsXlIiqSw1ZtBxPwRI+0aXDN7wsXh9gYGv/37d+yQBs7p5zUxAkIWk47EH?=
 =?iso-8859-1?Q?HRsXibuZH/BDc3KwW1aUa8ud7SsdzzEn8Yc2JpaL2VkRTWx2+N2RdHGZqo?=
 =?iso-8859-1?Q?pUELiscLEzw8mVOJHIbRWhOug0Uyrdb3f3cKwnYkgno5z/FGO2lektgGR7?=
 =?iso-8859-1?Q?rPMoVwX9G0oWcW0J0kpOvXCxhVInAJVMCywklnTb/aI5vu2NcjMBu0dIRm?=
 =?iso-8859-1?Q?RDNeGUctynRmSaOPisT6i40c8Z8pZZqjO+9cJBbuRZzN5W9QMTxij0dd8q?=
 =?iso-8859-1?Q?H/X+j8HrDIHBOJ7j/6yQd3tOpwAXBBL1FHu/oB/JOnRX68PKS4HjlBMmpt?=
 =?iso-8859-1?Q?BuZSm4jxParO+6ILhTLVpTtdWPWM9VDhTkXAybLTCVBgy6dYkkCToLrj+w?=
 =?iso-8859-1?Q?EfhtD/dy2ABsHmfAY5Uc4U2s7q8xlghI74vcXkHE8MKaio5e6BBYcY4BPQ?=
 =?iso-8859-1?Q?fBxz1hXuuxsxLVUaL+k5LKd51FL/9MaNW+uY4xsUJNEqFY9b7/bVtXlzSr?=
 =?iso-8859-1?Q?gEYhxIgMdMcBnQyXNWsu2Gq+EPOkve2uJzpLuMkgFtJvzkR0sklSrNw2EW?=
 =?iso-8859-1?Q?ul4llpdN1kx5sUOMhzMeirvu830KuU5fTnuHLWBfocm+uXb7eOkUTJpMag?=
 =?iso-8859-1?Q?ArNsGkiWofPUjD7JiZZCDTtiWHhT6cyOGTPT/Wp4/m0e0VfX4o/wyRL26X?=
 =?iso-8859-1?Q?gvqSDdo4wTr+C42WnAVQ24+jwIdLoIxjnoMT/ixWXqk9/TAcb2ULHztyop?=
 =?iso-8859-1?Q?9LZtwS80stOwsXqekbJVpWeLfQK1jr7ynrliPzcWi21NlAI4uPrTuM1AAT?=
 =?iso-8859-1?Q?ooazxqi8Z5ezP4rV4Z/gc2oZkq5e0AVZX66Q4OV02+zEmtR9PJaxoCA47w?=
 =?iso-8859-1?Q?r2ZKgqYY4YjyFtkbIbxigzf+emwyU/BkH9lmk3NFmuyZH6c24lglE0+Wxe?=
 =?iso-8859-1?Q?zxrP2rkmKwTSLzCYtt/jP36OzW/eTwkAHB6BcIo7Jc2DHswg2Ej8aaKcVL?=
 =?iso-8859-1?Q?rctHSnF5Ja7S1M0tJthoGTdJ1A/VMv3ffBRxNy/mcy0wk3rXnJjQ04ikxJ?=
 =?iso-8859-1?Q?R/G6W8vpJq56KgwmFW0Mrlla57cgYrEHJBQKX3DiyujkWB98i/mx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf7427e-14c9-4485-9b51-08da24b392e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 22:58:10.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhsQ/wyitFswH3GJvWVNrcxOaBhAVabPygFNNrJfcg8a/EdH71CCbWhSWYCKXBy4aOEky0MGWArrBQNuXoRulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6595
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever III <chuck.lever@oracle.com> wrote:=0A=
> On Apr 21, 2022, at 7:52 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:=
=0A=
[stuff snipped]=0A=
> > I took a look at crispyduck's packet trace and here's what I saw:=0A=
> > Packet#=0A=
> > 48 Lookup of test-ovf.vmx=0A=
> > 49 NFS_OK FH is 0x7c9ce14b (the hash)=0A=
> > ...=0A=
> > 51 Open Claim_FH fo 0x7c9ce14b=0A=
> > 52 NFS_OK Open Stateid 0x35be=0A=
> > ...=0A=
> > 138 Rename test-ovf.vmx~ to test-ovf.vmx=0A=
> > 139 NFS_OK=0A=
> > ...=0A=
> > 141 Close with PutFH 0x7c9ce14b=0A=
> > 142 NFS4ERR_STALE for the PutFH=0A=
> >=0A=
> > So, it seems that the Rename will delete the file (names another file t=
o the=0A=
> > same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,=0A=
> > because the file for the FH has been deleted.=0A=
>=0A=
> So, Rick, Andreas: does this sequence of operations work without=0A=
> error against a FreeBSD NFS server?=0A=
Good question. For a UFS exported file system I am pretty sure the server=
=0A=
would reply with ESTALE to the PutFH, just like Linux.=0A=
=0A=
For ZFS, I am not so sure. The translation from FH to vnode is done by=0A=
a file system specific method. If that fails, ESTALE is replied. If ZFS can=
 still=0A=
generate a vnode for a file when it has been removed (or while the remove=
=0A=
is in progress, as it might be in this case), then no error would be replie=
d.=0A=
(The NFSv4 Close operation doesn't actually use the vnode, it only uses=0A=
 the StateID and FH to find/close the NFSv4 open state.)=0A=
=0A=
The FreeBSD server never sets OPEN_RESULT_PRESERVE_UNLINKED=0A=
in the Open reply and it is not intended to retain the file until Close.=0A=
=0A=
Maybe Andreas will find that out, if he can do more testing against a=0A=
FreeBSD server?=0A=
=0A=
I am also not sure if the ESTALE replies are an issue for the ESXi client, =
since=0A=
they happen multiple times in the packet trace and only generate a warning=
=0A=
message in the client's log.=0A=
=0A=
I did not see anything else in the trace that would indicate why the client=
=0A=
might be failing, however it did look like some packets were missing from=
=0A=
the trace.=0A=
=0A=
rick=0A=
=0A=
--=0A=
Chuck Lever=0A=
=0A=
=0A=
=0A=
=0A=

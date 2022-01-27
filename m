Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214249E993
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiA0SBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 13:01:49 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:9825
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbiA0SBs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 27 Jan 2022 13:01:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5qpw36uOjh8/doPkE1WmFOcfMjHKhn8NKdAlAk5mEi/iDJ79f1V5udL3FyVrJDFaPNGkeHlJDVJGG0C3MLGGzeGGKTM/N79WLQ78bFsENeIWoGLj5aPHl9+1DlHgDpWwlwQXfz24FUnGogxg/zLU/po0345THg0dZCyb0GBbTvqOehx6q5I83/L6W0wGB0z348WktWbxSguL8w/6DBhta0QDs65BGjCRRL1f2SxXSd+6pBWLeMvL6nO9lyQtHasP73cAaXloyYTm0IqrNIoMoBZ26aNrwjqE3rjGPUu6OAQFz1Aw2fUiZYWfwKdnsgHsdW0ek5BEvPaXf1VC37J2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPaCtjfYlPlYac0yhs6hQYxJ/iQ0wxSee4WQKD4oShQ=;
 b=Ra/wKaFhBVhkeb+nNxah7e0AijpJZORlHHI3usDteN0KjbHzAs7BQOz7DGAAbY7nyX2tpKk2P9kQDz3lz/Xtb9lc3WNlhj8y96AiWfdx7/CwyHfhiOeIGSWydesINJoqsfPZqM/UZ49GgiKhwAmNzbz35DTY44b/CRNCigrDP2K7FOAbi5ftyCQPcQGoqehQg/swk+5eyfxplu4MTpjGTZF7zNtQR6i8EUKwE1HB6XU0UmBGf1a8e2RuMtCxKxHS5CcO0V0GD5r+XyKD6BZR9Y9SCCHjTPwQjUDWZISrrSXu163mgG9nsu92OmrVj9YKZGJSRzKuv4E8sRcJ8e4IKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPaCtjfYlPlYac0yhs6hQYxJ/iQ0wxSee4WQKD4oShQ=;
 b=yZo9euZ2NdhxctsurLGSNch5Q7SOAcPXVuVO8QSaHlriL2nLfMrVbRuDFQ6MrJ6TfbPGDBkPMK5kPexh/HwhWebDYwxH1fAerorOMJWzz2GiYVP8Uakd0TR2QdNfvZpIcpBQ6xrtAAwIJLFWIUMNI08ZYPj3bhLjlpxv0EY5NJrzTSjDlrl+A165GmRDCEpa33BscQ2r6zq5bGGtP+MC188eqGLYsk6fNgfB3PNitR1J/MEaqen1Dgg1+BIFdzgnVfkGImMnuUk9wyQlgHCrWXRYmo8VRfUEF4JscZmf5Fokmokqljud3SGYY8IameG7T43wvn1CZJE+t33N1whcSg==
Received: from DM6PR06MB6026.namprd06.prod.outlook.com (2603:10b6:5:1af::12)
 by BN8PR06MB5697.namprd06.prod.outlook.com (2603:10b6:408:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 18:01:43 +0000
Received: from DM6PR06MB6026.namprd06.prod.outlook.com
 ([fe80::bc64:1dac:860b:1e33]) by DM6PR06MB6026.namprd06.prod.outlook.com
 ([fe80::bc64:1dac:860b:1e33%5]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 18:01:42 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     Rahul Rathore <rrathore@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>
Subject: Re: ERROR: sysfs is not mounted (Add a tool for using the new sysfs
 files)
Thread-Topic: ERROR: sysfs is not mounted (Add a tool for using the new sysfs
 files)
Thread-Index: AQHYE6AXMvdvIurluUehNJRokUWwU6x3J9So
Date:   Thu, 27 Jan 2022 18:01:42 +0000
Message-ID: <DM6PR06MB6026A41A0391E5CD39964098F8219@DM6PR06MB6026.namprd06.prod.outlook.com>
References: <CA+-cMpEeRO_c2onANUFnBjdHnu+FT17Toebwndu8E7hNuZUp8g@mail.gmail.com>
In-Reply-To: <CA+-cMpEeRO_c2onANUFnBjdHnu+FT17Toebwndu8E7hNuZUp8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f85995b-f9cc-4f26-dbe9-08d9e1bf1359
x-ms-traffictypediagnostic: BN8PR06MB5697:EE_
x-microsoft-antispam-prvs: <BN8PR06MB56977D367104607DB82F0F73F8219@BN8PR06MB5697.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2wOko2R9bkr/ar3dfhgA3Tz2xuEVY/1kbGBuNBJWkpt24hYSNtWk61tKeNpzJcOGkBKApvjcBuaw4HKbd28Yic9La1b+xE6lPcAEZdywdrx+E4A03ovQKwkV0yjgyMgNV9cH+I/b69Aw7iKBS9O4PeOi5c3yYDiZtj93rvvPUaBlLLeMLGPE2vy8qWwcN4eQL5dP8622CN2U6CoHQTd19nUaVTzKsRNq/bH4/mvrYYoMpy002/gZ7tKav3GTH1SzXvXVW8gf92Tew2pbaQanv/FkCPOp1jswyMXMT1azHLbhOtrzIkrNyVxbuSO7QhfkOkojoXXVNiL1152OH7QCssVtbD6/1YYHHSZv20oLD60x5mv9npLfifPCQAFzw+VnIjaCJDYppBPEhIAuljFCG7WBoDloJ26VYIppwCeTsxLVmwEz2aL8BrMVjGHqgkqMcp6GkkqjsAQygVaKO1hLsF98xeJGN6rnG1MXnEGwDSgmx1WPmzXO1+6dJIOu73Sn2JKi/m+B3/afkqdIYy0QfY+QZq7+EncwloEUAMUcGH2B2PmSJfCDpfpFDLlnoOokxZWTcfJHyqjsncR9NaYUR9b/dpumHkHBs19aqFqme8OsxwObFx3aFDuY5Rm6flzFmB5wDHuxXkHHB/TK2jyUR/kEjKEPECA+UNbI9OEL16LF+Ns4z83NgZhYQyz/2oq3bkbM/qo88YT8pWz2aUCaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB6026.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(9686003)(55016003)(5660300002)(122000001)(76116006)(2906002)(186003)(38100700002)(86362001)(83380400001)(7696005)(52536014)(6506007)(91956017)(33656002)(71200400001)(4326008)(508600001)(6916009)(8676002)(54906003)(64756008)(66446008)(66556008)(66476007)(316002)(38070700005)(8936002)(66946007)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I7UEdM+qyUyK0SfSnJNM3EGpjMZiFa4mlimkn4I+oO6pOtqza8JYun6lOj?=
 =?iso-8859-1?Q?JGzh7hKVARCPHsK+Y1TLtRPomzQ5K5DZRUTM3gaDqGq8vdbFWc+6pPVYsb?=
 =?iso-8859-1?Q?3D6GDB2Akm2u4ofDVTwb/rFoBXYJEhuQ2JqwVeKPHmC8JAgKptQZV39rAN?=
 =?iso-8859-1?Q?UZ3GqlYoQvUfrWxW0z0UFUyszM+vLefkZmcs/ALLxWve2o05WSaN86NO9C?=
 =?iso-8859-1?Q?ECH1ZBy/+h3BM+8hvleIGu+gQ+1wyVtHCdBn0i3+nQc50ygMGa0kRBNyB4?=
 =?iso-8859-1?Q?i+OFg4toYF3bK/b61KI6xqTyk34HFhxixD3n1Bpyr39o6XLLEv5dC9+NfM?=
 =?iso-8859-1?Q?/sBbNSGgNwGSapoYzqNkysNDZ/E1mo6WNraB56z+5NgKhLBWld4pbsvudv?=
 =?iso-8859-1?Q?8O+sX17Ayja3ZuiBD358pZe+HKXm4NG/ns5ea3/23aTxvChlgJoRzQacWN?=
 =?iso-8859-1?Q?0dH6eo3TZ2NemHOBFjhc1+Sii+PWlBFBFGFZldd0F+eKZXOoQCua06MqAT?=
 =?iso-8859-1?Q?VYTpb+2zMsP0eg/FVC2659wFKoiO4BYKOrhUB/BbNbKX5OQh84o7q4ILzn?=
 =?iso-8859-1?Q?9gi51WzjRr0Y0s0KJywDNnxjrPVhPwgk2Hg853NPjJ07dRvGwzgZ4cM/xe?=
 =?iso-8859-1?Q?KGJJ+31FmzqUi+OE17+R5+Jyv48qqOTzAKF1gJ30dEjCciuIlki/n8vL+4?=
 =?iso-8859-1?Q?eTghiVBMy9NtqNcUlJlT9J1AbXViKiiTCikQwS7328j+eweSQR2B2AK2Zd?=
 =?iso-8859-1?Q?3AgvTsijIH2xLksz0IOjx75Q7k00Ok7cjEQ0mVs8Dqr5nJSY1bFiZ1XjwE?=
 =?iso-8859-1?Q?huo0GDVlNcAGO7jVxu6Q9FsZFepTwvtJWOKWcsTvS9GsJjlDicv7ZYYDcc?=
 =?iso-8859-1?Q?3b2hyOgVMbX8WO7d0RbjCSgs3JyoLxg1VICgvPIJoI8o1IDAn6HLP/hoJU?=
 =?iso-8859-1?Q?m+RVNiLa4PjDWQ/yUhdhmQZg7EjROEZkwco55e2Agq1YRRede2Cgh9CzFW?=
 =?iso-8859-1?Q?AFpL4nnhrIc1meUNLOl1Zr3JWURr/wGvCRv/zf6HrdhOMJ8z5SKf6LI3FK?=
 =?iso-8859-1?Q?77VzQz+6qNTaFT8+ZN+zo1xyrG1e0t2/WlRnjgZfJLnxfTiVNwKkOpa75j?=
 =?iso-8859-1?Q?xQuW1posmZq+O9ATMdtlg0zmaIyuRE7/TV2dHI7B4quVWEUEmvYPtu+hW0?=
 =?iso-8859-1?Q?mtIhpyYwab/lXw14zWfV49k5OBNbNzSZTr9/SbcMZFWW524iEAXv2MQ1Zd?=
 =?iso-8859-1?Q?jjuj6grsSWNBt07Wr4yV018b9JZI2YC/dkbwBCV9+JD1PUL3kezKNMnQMZ?=
 =?iso-8859-1?Q?pJj0KLXY76NxurglT9tZS/gCzBlr2IRz2g9/0idL60onUfym2kjmBKtsbq?=
 =?iso-8859-1?Q?uMOhANIQ0rYp8Zprhrdxr2P64RT6Hndsz5NTRHohHqHhUJSgPc0lLnjYMo?=
 =?iso-8859-1?Q?UqlMC3h/GfUD51TSB1COdkeLGxKWpnQNN+S4IXNSs3/WnERDVhIE3LGTj6?=
 =?iso-8859-1?Q?fNc6VdAMPyi+0ooEn03hIkmbLyL+e+UxXOXQSOBa8GGsSSuHJpGVmWvJ/s?=
 =?iso-8859-1?Q?F0PiErY1vs07dmleOCUQOo1Mf0Zo8XDh9APjXMYheKc/1GFix1QVBR49Tq?=
 =?iso-8859-1?Q?o7QsxUO1Ro/g9qyIyvvF4NvT4FAOqrc6qK2vfvwcHxPYG5miKiNDVlgofv?=
 =?iso-8859-1?Q?GGu+kABi7tLN3cXVk+VeRhneScgV+ehs34kBAsTMeuEwtwJtx0D/yope61?=
 =?iso-8859-1?Q?EWRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB6026.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f85995b-f9cc-4f26-dbe9-08d9e1bf1359
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 18:01:42.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bm0dEjlrwQmG7TMXiBhwxv9m5mvdl5HxGyTvofQ6SrL8y2Oy6EmaAq7opoVru7rauYizgAvnEteWunbBaCfmjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5697
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rahul,=0A=
=0A=
=0A=
> From: Rahul Rathore <rrathore@redhat.com>=0A=
> Sent: Thursday, January 27, 2022 12:05 PM=0A=
> To: Schumaker, Anna <Anna.Schumaker@netapp.com>=0A=
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>; David Wysochan=
ski <dwysocha@redhat.com>=0A=
> Subject: ERROR: sysfs is not mounted (Add a tool for using the new sysfs =
files) =0A=
> =A0=0A=
> NetApp Security WARNING: This is an external email. Do not click links or=
 open attachments unless you recognize the sender and know the content is s=
afe. =0A=
> =0A=
> =0A=
> =0A=
> Hi Anna,=0A=
> =0A=
> Hope you are doing well.=0A=
> =0A=
> I was trying to run the tool. I am getting the below error.=0A=
> =0A=
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py =0A=
> ERROR: sysfs is not mounted=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <-------------------------------------=0A=
> [root@rrathore-upstream-sysfs nfs-utils]# cat /proc/self/mounts | grep -i=
 sysfs=0A=
> sysfs /sys sysfs rw,seclabel,nosuid,nodev,noexec,relatime 0 0=0A=
=0A=
Oh, I see what it's doing. The beginning of the line is "sys" on my system =
and not sysfs:=0A=
=0A=
anna@gouda ~ % cat /proc/self/mounts  | grep -i sysfs=0A=
sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0=0A=
=0A=
I could probably check the fstype column for sysfs instead=0A=
=0A=
Thanks,=0A=
Anna=0A=
=0A=
> [root@rrathore-upstream-sysfs nfs-utils]# =0A=
> [root@rrathore-upstream-sysfs nfs-utils]# uname -a=0A=
> Linux rrathore-upstream-sysfs.example.com 5.14.10-300.fc35.x86_64 #1 SMP =
Thu Oct 7 20:48:44 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux=0A=
> [root@rrathore-upstream-sysfs nfs-utils]# =0A=
> =0A=
> It is throwing an error even if sysfs is mounted.=0A=
> =0A=
> Please can look into it.=0A=
> =0A=
> -- =0A=
> Thanks & Regards,=0A=
> Rahul Rathore=0A=
> =0A=
>  =

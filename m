Return-Path: <linux-nfs+bounces-1633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB31284469F
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8461C22C6B
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60212BE8D;
	Wed, 31 Jan 2024 17:58:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2107.outbound.protection.outlook.com [40.107.127.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DF12FF6F
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723936; cv=fail; b=fsRs4bxVpGovpMB1lnOwWyqh3YIqMGPgtxlx6uAul5knB78coof/QHU0T/aawa0TYay4XQfcaglXbKp8v60sl93lu8+0zaUe4FhUeh7xOJ4FB8GT2Sq25zLHS31hJZx+7jOjFG+5tpesJbvVL2gY5eXwWPiYO7yamAO/1LTcXyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723936; c=relaxed/simple;
	bh=gR0s1h9mo0Ren0P8LAbDiq6Z84R45/Wy21Caa/26gGY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eWtDwYTJSjtla6qwiYNfh2M5G8cq+SgqI5xmBcSkpfEUaKBX617joIZLQ/qdAUEnl49O0ws+0YPWt6Gq8YebLIWOgPB6zl8IWktTJoKx/uZiC83LaKZLe+00oGww7Jromi+NYyO/1bQ7Gk9zAxR3Bmiw4zUmBVAcEoSVBkEoLy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=index.de; spf=pass smtp.mailfrom=index.de; arc=fail smtp.client-ip=40.107.127.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=index.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=index.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvae65S6UT62hp5qVG2tQspEjkJ4MyNMTufSh2H/LlWC5dy0JQzjIIAfzMxsEGMfnJgMNn9Ab+4zOpjpHbYFpwzRvYcpW4qyoiK9zE5xd75TC3YjpolQy9v34/9DxMHaCQ5N4JhTMVl7oqObSRldhvFT94bPoVjM6TQccBDXDVYdGYGy9rwrtrkf0DVUHuFP+Fj715Q3ZdJ7Zc3Y5pBTZ/hJtZMEfl9EXxPCMMR9uOy+lvWbA5l+2qa29cz6nrJQd8w6jBeASqDLaG3SzzWFUynUTOIP8wqCCjrpqRKCcRpgexCGOekDYf7NL2vSz5iXArPr3CwczDxcLLoqwDnhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR0s1h9mo0Ren0P8LAbDiq6Z84R45/Wy21Caa/26gGY=;
 b=Fd3dOtKnQpFE9WyF5nN3+A8xbFCqVk9A45yrIuB1ZKkLwluWQJ4hGReSM8HEoUJXGk4XdYTNVVJribws34iLwNA42fhmVohSsKaAyM3tm1vKpGNuqcKDhqsznBnGe34J+/PcfX4MJGjIAkDlcROTRUn3NNlND4J68GrPL6l/PRJuqO5Dsq7g02Eubx64BbuBXWddw19iETrZM9ySyjM22cXsejkANBI/ZDLB8kKfO6RD4A6tNex6PH3pZWv6dNvtgSfTQ8Y5/0sI87XmYNgcIAV7DmRrLZ7JDd57shrvlCEPgSLJMH+seppHgtT3jhXWl3Y3si9tNK7TyDtXobY4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=index.de; dmarc=pass action=none header.from=index.de;
 dkim=pass header.d=index.de; arc=none
Received: from BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3c::7) by
 BE1P281MB1875.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 17:58:48 +0000
Received: from BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e796:2374:ecfb:4172]) by BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e796:2374:ecfb:4172%7]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 17:58:48 +0000
From: Sebastian Zillmann <S.Zillmann@index.de>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFS Clients getting slower after a week
Thread-Topic: NFS Clients getting slower after a week
Thread-Index: AdpUbZ0zU3xjiNOrQGyantasKFqaeAAAHcdg
Date: Wed, 31 Jan 2024 17:58:48 +0000
Message-ID:
 <BE1P281MB2770294E96AFE4D6F834D23EE97C2@BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB277001F97883545CBAE09FB7E97C2@BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB277001F97883545CBAE09FB7E97C2@BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=index.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2770:EE_|BE1P281MB1875:EE_
x-ms-office365-filtering-correlation-id: e4049878-9583-4df8-865e-08dc22864672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3zHXecFV1c1jA39IU2ruCateym28JR0RIh4Iw7it+to8I1x/u7ocQVQKasIfq5PPSRgrJIGZNJgWHXFgdgGfCh1tEl/ne828xkwcT2tR9j1h5CUag27UYMSJRJtfcXpKPxD6QMP1D0WUi3aYwpw5f0ZRRnob0Zb/hmaA2ty8tPqSzazX5oGOO8sj+42dt+K0s2Wv+icu+nWzAOwwyoogw9KWOVnzc1ROD9i2oX2HDkz3P2sX7A/qjqWRcc2bj72JcSxLUJaF2XlAsRV4pDt7xWLSDb9MAVpT9B+bbR0EM00jWtxFDl0fXXfRybcmyHICdMydEA/6s3ZSmMEnRg8S40q01wbDRkOLKk7yUdi8FAv/LpK5m2zzsHrHxkrKlf4xZ3RDgxiuY83iYHLDmOZ82uP7AEHtn3NgfnvEY2zsRgMitAWo8hpLFtonD2RFrO4LUKpL7WjbeHKreRZyG0KRbHCM3gEsviiPFVXWn4XxFN+77kgpfMSk8+grInY4wdFuxEALhK+mOaWWvpGTJURsgqfvvugzVqAGmyLZRdwQ8ObeKwuc4zIPib/q5pu0CSs+8Wtq7Qlpop5RLGeHnG/3GToy9jjDhWUrFSq1DQIDSBY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55236004)(6506007)(7696005)(9686003)(2940100002)(8676002)(26005)(966005)(478600001)(2906002)(52536014)(316002)(8936002)(38070700009)(30864003)(33656002)(71200400001)(86362001)(5660300002)(76116006)(66446008)(66476007)(66556008)(64756008)(6916009)(41300700001)(66946007)(55016003)(38100700002)(83380400001)(122000001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+/ibrKYZWq1xxgRdzufuaM3vhsKVQzRpeQ50eRRObpgodsIs9z4N3fXStw?=
 =?iso-8859-1?Q?5qFD5dlCcFlLKg97gP+S9xns0/0GooLjn+BKiSs+nerFAyzTaTkZrR/RgP?=
 =?iso-8859-1?Q?QDKlCWf4WogucKtob0xiufvRUWt0fBz7NaU0wvqoLf1Ogu9W93E3Wha7pC?=
 =?iso-8859-1?Q?DpaEIw2CwTehg7zohRXKyv95XWzVBWzLgwlc6rZaR9uGl+YBjr5ovCds9G?=
 =?iso-8859-1?Q?9XYn1wF+yU97pl+/AJI5t5jyWdPw3Yjq3Z9HaFqwJ/df3/sulPDEhV61km?=
 =?iso-8859-1?Q?msiYai4xjs3p0AluqJ5l+qt7C4KZt4H4jzrG/wwGwLA8p2XTUYG3nhA/FC?=
 =?iso-8859-1?Q?l3E513/OlQOR2RhIInb5SHeklPI/nEf9Z0XIVu71MuDesxv1+dMHQQUptL?=
 =?iso-8859-1?Q?jOE0v94FJD6l8v452MT3zud9jhFhEpKdtqbnEoOqrLuBdzuSgCvuM425f8?=
 =?iso-8859-1?Q?S/G8QGdtYc14w0LW7so1Pzo3vTr0JkcOT23zHYik34CZ4xDsRkZN+e59xq?=
 =?iso-8859-1?Q?NqUMQ9Ji1kxmZ+pmsRb10+dOc3V4juHu0MEi1tW61gJXDvXM+YflZiqmhl?=
 =?iso-8859-1?Q?V/WEY2P6DJ+KbnSn48ELoTEcpSskedDOjH6P7k0fdvjqvz4A7tYUjhWf5H?=
 =?iso-8859-1?Q?B+e/Nof0pgTks9FMZvOmjuN6r1M3eE7W4cXeZPC3KMsmgmdjm+oGagPxnH?=
 =?iso-8859-1?Q?G+SAo5b9BPr6lnTgZ7olqMFMKdbUhX7iJmZXzrN3pnjH0r8lvgiEptz4T2?=
 =?iso-8859-1?Q?LbKujiBbuy1bIQKh/K19gOtRgXtfvmkEYl+6gC1Oi+Np9MPUFNukGYAA5y?=
 =?iso-8859-1?Q?PJnLrfw2UQSITBTpvsQ03ENj5wAjFOeK3+3i/blPzddXyPVGT9u249YC0y?=
 =?iso-8859-1?Q?gbsthpIP64NqSvthA0FERH3L4fGBdphocHZuwYZpNxk5VH/8JDASGqlp8N?=
 =?iso-8859-1?Q?FQiH1T/FeZ26G1vnI9uRau2kXe1WBjOPieEo8sD9tDp5Db2b5HiHZIr4rA?=
 =?iso-8859-1?Q?j3LliXL0vifLwtFDeqs8NDKJKDGpMxam8tYYLiLT+wWqS8UGdU00m0woqJ?=
 =?iso-8859-1?Q?zrsz+rkZJPxsYMki+Ytb6UTJD7iQZ5ezvw40l/Ob9xV+G7qg7TImeyWiQh?=
 =?iso-8859-1?Q?GklyxY1sjaPkZLBNUontrmZMd/SnY72KMOaqc/4EYu3ST+uSPLwHjIwN3J?=
 =?iso-8859-1?Q?OlInZnW+1zXt8yeiZL67F9kWW1h4HeJttOYkXgt98yUctQ1FwQn2DR9vQ+?=
 =?iso-8859-1?Q?pZbsi7Hf0/F/PlQzTl4oJE8yliTiink+/A6qTMs4KFLHeGkjZ9e/XKhctU?=
 =?iso-8859-1?Q?T4DEpvJIAFqP/IGo7QpEkSkkptQsnqy2ge/T+4MTkKfEXcJdOGbAyPAIQQ?=
 =?iso-8859-1?Q?qudTVJ09RcgRpzfDInH42HCsSQ64wEq/QURM+O4WLbax4alvkMLwbeA2U3?=
 =?iso-8859-1?Q?5EYDstjbJ8A1yBWdK4SDsVcpvd5hlrYjZYBDFfMEqbFgKFS+8Pc9xzls2h?=
 =?iso-8859-1?Q?0lLB61catQ4hS2rvOPWu+AOeRbM1pVWX6HIYu6kJnq1tc8XPUbt8GCBLk3?=
 =?iso-8859-1?Q?9sW3gh0/yfs3LPTpLCYw5m0m9bTk5lY3xFr42O3j6LsKugMRKqMp3j8UCO?=
 =?iso-8859-1?Q?AwcBSHDjcw8PY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: index.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2770.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4049878-9583-4df8-865e-08dc22864672
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:58:48.2046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44108fdf-38e5-47f6-9e2f-70e5748c757c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a69hzA2jvHds2bxki1iHMcdoyjBpu9jmHfwnfW4C5TIksB3Xe9SQYB7azKlE4fTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1875

Hi,=20

We are using 8 virtual machines (some ESXi 6.0, some Proxmox 8.1.3) to exec=
ute scripts which read document files and write results in a database.=20
Reading 40k documents in a minute is nothing special.

Starting with 2024 we are getting problems and have to schedule weekly rebo=
ots. We did the last client upgrades on 30. November 2023 and server upgrad=
es on 23. June 2023. But we created a new ZFS File System with sharenfs for=
 2024.
First error happened on the night between 10. - 11. January 2024.=20

Cpu sys time avg is 5-10% for the first 24h after a reboot and 25-35% for t=
he last 24h before an issue occurres. We don't know how to reproduce the er=
ror besides: read much for a long time..
We are used to having 5-20% cpu sys avg in 2023 without issues.

We know an issue occurred after:=20
- Nfs client value test_stateid increases over 10k (highest went from 6k to=
 over 4M in 3h) and every nfs request slows down, higher test_stateid means=
 client getting slower. Clients keep being slow even after you kill all pro=
cesses and start a single performance test. No other clientvalue changes mu=
ch.
- "rpcdebug -m nfs -s all" shows: Jan 15 13:47:29 merkur6 kernel: nfs41_han=
dle_sequence_flag_errors: "192.168.2.233" (client ID 8ed80a651d5a6f4a) flag=
s=3D0x00000040

All 8 Clients had this Problem once or more times this month.=20

We do not use any security options.

Slow Client:

root@merkur6:/var/log# time ls -l /dokuserver/anzeigen/2024/01/11/11/
real=A0=A0=A0 1m11.308s
user=A0=A0=A0 0m0.239s
sys=A0=A0=A0=A0 1m5.375s

Fine Client:

root@merkur3:~# time ls -l /dokuserver/anzeigen/2024/01/11/11 | wc -l
47117

real=A0=A0=A0 0m2.222s
user=A0=A0=A0 0m0.307s
sys=A0=A0=A0=A0 0m1.502s

Server:

root@herodot:~# zfs get sharenfs herodot_zfs_pool/data/dokumente/anzeigen/2=
024
NAME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PROPERTY=A0 VALUE=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SOURCE
herodot_zfs_pool/data/dokumente/anzeigen/2024=A0 sharenfs=A0 rw,no_root_squ=
ash,sync,no_subtree_check,insecure=A0 local
root@herodot:~# zfs version
zfs-2.1.5-1ubuntu6~22.04.2
zfs-kmod-2.1.5-1ubuntu6~22.04.1
root@herodot:~# uname -a
Linux herodot 5.15.0-75-generic #82-Ubuntu SMP Tue Jun 6 23:10:23 UTC 2023 =
x86_64 x86_64 x86_64 GNU/Linux
root@herodot:~# exportfs -v
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.102.110(sync,wdelay,h=
ide,no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.102.14(sync,wdelay,hi=
de,no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.2.0/24(sync,wdelay,hi=
de,no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.3.0/24(sync,wdelay,hi=
de,no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 172.16.2.0/24(sync,wdelay,hid=
e,no_subtree_check,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10.8.0.0/24(sync,wdelay,hide,=
no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 192.168.103.0/24(sync,wdelay,=
hide,no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10.8.0.0/23(sync,wdelay,hide,=
no_subtree_check,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/scanner=A0=A0 192.168.2.0/24(sync,wdelay,hide,no_subtree_check,sec=3D=
sys,rw,insecure,no_root_squash,no_all_squash)
/data/scanner=A0=A0 192.168.3.0/24(sync,wdelay,hide,no_subtree_check,sec=3D=
sys,rw,insecure,no_root_squash,no_all_squash)
/data/scanner=A0=A0 10.8.0.0/23(sync,wdelay,hide,no_subtree_check,sec=3Dsys=
,rw,insecure,no_root_squash,no_all_squash)
/data=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_subtree_che=
ck,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen/2021
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen/2022
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen/2023
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen/FIRMENLOGOS
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/herodot_zfs_pool
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/data/dokumente/anzeigen/2024
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <world>(sync,wdelay,hide,no_s=
ubtree_check,mountpoint,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)

First Client (merkur7 /Proxmox Client):
root@merkur7:~# uname -a
Linux merkur7 6.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon N=
ov 20 18:15:30 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
root@merkur7:~# mount -l
[removed local mounts..]
192.168.2.240:/exporte on /exporte type nfs4 (rw,relatime,vers=3D4.2,rsize=
=3D524288,wsize=3D524288,namlen=3D255,soft,proto=3Dtcp,timeo=3D600,retrans=
=3D2,sec=3Dsys,clientaddr=3D192.168.2.191,local_lock=3Dnone,addr=3D192.168.=
2.240)
192.168.2.233:/data/dokumente on /dokuserver type nfs4 (rw,relatime,vers=3D=
4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,soft,proto=3Dtcp,timeo=3D6=
00,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2.191,local_lock=3Dnone,addr=
=3D192.168.2.233)
192.168.2.233:/data/dokumente/anzeigen on /dokuserver/anzeigen type nfs4 (r=
w,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,soft,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2.191,local=
_lock=3Dnone,addr=3D192.168.2.233)
192.168.2.168:/data/dokumente/anzeigen/2005 on /dokuserver/anzeigen/2005 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2006 on /dokuserver/anzeigen/2006 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2003 on /dokuserver/anzeigen/2003 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2008 on /dokuserver/anzeigen/2008 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2010 on /dokuserver/anzeigen/2010 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2014 on /dokuserver/anzeigen/2014 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2011 on /dokuserver/anzeigen/2011 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2004 on /dokuserver/anzeigen/2004 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2012 on /dokuserver/anzeigen/2012 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2019 on /dokuserver/anzeigen/2019 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2007 on /dokuserver/anzeigen/2007 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2015 on /dokuserver/anzeigen/2015 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2017 on /dokuserver/anzeigen/2017 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2016 on /dokuserver/anzeigen/2016 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2020 on /dokuserver/anzeigen/2020 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2009 on /dokuserver/anzeigen/2009 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2018 on /dokuserver/anzeigen/2018 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2013 on /dokuserver/anzeigen/2013 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.191,local_lock=3Dnone,addr=3D192.168.2.168)

Second Client (merkur6 /ESXi Client):=20
root@merkur6:~# uname -a
Linux merkur6 5.15.0-88-generic #98-Ubuntu SMP Mon Oct 2 15:18:56 UTC 2023 =
x86_64 x86_64 x86_64 GNU/Linux
root@merkur6:~# mount -l
[removed local mounts..]
192.168.2.233:/data/dokumente on /dokuserver type nfs4 (rw,relatime,vers=3D=
4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,soft,proto=3Dtcp,timeo=3D6=
00,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2.184,local_lock=3Dnone,addr=
=3D192.168.2.233)
192.168.2.240:/exporte on /exporte type nfs4 (rw,relatime,vers=3D4.2,rsize=
=3D524288,wsize=3D524288,namlen=3D255,soft,proto=3Dtcp,timeo=3D600,retrans=
=3D2,sec=3Dsys,clientaddr=3D192.168.2.184,local_lock=3Dnone,addr=3D192.168.=
2.240)
192.168.2.233:/data/dokumente/anzeigen on /dokuserver/anzeigen type nfs4 (r=
w,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,soft,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2.184,local=
_lock=3Dnone,addr=3D192.168.2.233)
192.168.2.168:/data/dokumente/anzeigen/2010 on /dokuserver/anzeigen/2010 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2008 on /dokuserver/anzeigen/2008 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2007 on /dokuserver/anzeigen/2007 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2004 on /dokuserver/anzeigen/2004 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2019 on /dokuserver/anzeigen/2019 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2003 on /dokuserver/anzeigen/2003 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2016 on /dokuserver/anzeigen/2016 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2005 on /dokuserver/anzeigen/2005 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2020 on /dokuserver/anzeigen/2020 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2006 on /dokuserver/anzeigen/2006 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2009 on /dokuserver/anzeigen/2009 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2014 on /dokuserver/anzeigen/2014 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2015 on /dokuserver/anzeigen/2015 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2011 on /dokuserver/anzeigen/2011 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2013 on /dokuserver/anzeigen/2013 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2012 on /dokuserver/anzeigen/2012 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2018 on /dokuserver/anzeigen/2018 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.168:/data/dokumente/anzeigen/2017 on /dokuserver/anzeigen/2017 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.168)
192.168.2.233:/data/dokumente/anzeigen/2024 on /dokuserver/anzeigen/2024 ty=
pe nfs4 (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,soft,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.2=
.184,local_lock=3Dnone,addr=3D192.168.2.233)

Some /var/log/syslog after an issue occurred:
Jan 15 13:46:56 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:46:56 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 33
Jan 15 13:46:56 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:46:59 merkur6 CRON[3797003]: pam_unix(cron:session): session clos=
ed for user root
Jan 15 13:47:00 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:47:00 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:47:00 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:47:00 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:47:00 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:47:00 merkur6 kernel: encode_sequence: sessionid=3D1701864457:319=
8674332:283960:0 seqid=3D278 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:47:00 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:47:00 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:47:00 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:47:00 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:47:00 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:47:00 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:47:00 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:47:00 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
Jan 15 13:47:01 merkur6 CRON[3797168]: pam_unix(cron:session): session open=
ed for user root(uid=3D0) by (uid=3D0)
Jan 15 13:47:01 merkur6 CRON[3797169]: (root) CMD (/usr/libexec/zabbix-exte=
nsions/scripts/iostat-collect.sh /tmp/iostat-cron.out 59 >/dev/null 2>&1)
Jan 15 13:47:04 merkur6 rsyslogd[3776903]: cannot connect to 10.255.1.14:51=
4: Connection timed out [v8.2112.0 try https://www.rsyslog.com/e/2027 ]
Jan 15 13:47:04 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:47:04 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:47:04 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:47:04 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:47:04 merkur6 kernel: encode_sequence: sessionid=3D1686681223:197=
2710396:429668:0 seqid=3D261856 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:47:04 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:47:04 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:47:04 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:47:04 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:47:04 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:47:04 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:47:04 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:47:04 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:47:04 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:45/34), mask=3D0x81, res=
=3D-10
Jan 15 13:47:29 merkur6 kernel: NFS: revalidating (0:45/34)
Jan 15 13:47:29 merkur6 kernel: --> nfs41_call_sync_prepare data->seq_serve=
r 00000000626f52bd
Jan 15 13:47:29 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:47:29 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:47:29 merkur6 kernel: encode_sequence: sessionid=3D1695209614:124=
8811549:744489:0 seqid=3D74093603 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:47:29 merkur6 kernel: decode_attr_type: type=3D040000
Jan 15 13:47:29 merkur6 kernel: decode_attr_change: change attribute=3D7287=
863876211365669
Jan 15 13:47:29 merkur6 kernel: decode_attr_size: file size=3D143
Jan 15 13:47:29 merkur6 kernel: decode_attr_fsid: fsid=3D(0xd9e5dc8000a3ddd=
e/0x0)
Jan 15 13:47:29 merkur6 kernel: decode_attr_fileid: fileid=3D34
Jan 15 13:47:29 merkur6 kernel: decode_attr_fs_locations: fs_locations done=
, error =3D 0
Jan 15 13:47:29 merkur6 kernel: decode_attr_mode: file mode=3D0775
Jan 15 13:47:29 merkur6 kernel: decode_attr_nlink: nlink=3D72
Jan 15 13:47:29 merkur6 kernel: decode_attr_owner: uid=3D65534
Jan 15 13:47:29 merkur6 kernel: decode_attr_group: gid=3D65534
Jan 15 13:47:29 merkur6 kernel: decode_attr_rdev: rdev=3D(0x0:0x0)
Jan 15 13:47:29 merkur6 kernel: decode_attr_space_used: space used=3D81408
Jan 15 13:47:29 merkur6 kernel: decode_attr_time_access: atime=3D1686643653
Jan 15 13:47:29 merkur6 kernel: decode_attr_time_metadata: ctime=3D16968380=
37
Jan 15 13:47:29 merkur6 kernel: decode_attr_time_modify: mtime=3D1696838037
Jan 15 13:47:29 merkur6 kernel: decode_attr_mounted_on_fileid: fileid=3D2
Jan 15 13:47:29 merkur6 kernel: decode_getfattr_attrs: xdr returned 0
Jan 15 13:47:29 merkur6 kernel: decode_getfattr_generic: xdr returned 0
Jan 15 13:47:29 merkur6 kernel: nfs41_handle_sequence_flag_errors: "192.168=
.2.233" (client ID 8ed80a651d5a6f4a) flags=3D0x00000040
Jan 15 13:47:29 merkur6 kernel: nfs41_handle_recallable_state_revoked: Reca=
llable state revoked on server 192.168.2.233!
Jan 15 13:47:29 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:47:29 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:47:29 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:47:29 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:47:29 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_update_inode(0:45/34 fh_crc=3D0x22=
7dee8d ct=3D2 info=3D0x427e7f)
Jan 15 13:47:29 merkur6 kernel: NFS: (0:45/34) revalidation complete
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:45/34), mask=3D0x1, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/anzeigen) =
is valid
Jan 15 13:47:29 merkur6 kernel: NFS: revalidating (0:43/34)
Jan 15 13:47:29 merkur6 kernel: --> nfs41_call_sync_prepare data->seq_serve=
r 00000000c979f144
Jan 15 13:47:29 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:47:29 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:47:29 merkur6 kernel: encode_sequence: sessionid=3D1695209614:124=
8811549:744489:0 seqid=3D74093604 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:47:29 merkur6 kernel: decode_attr_type: type=3D040000
Jan 15 13:47:29 merkur6 kernel: decode_attr_change: change attribute=3D7307=
486567865913980
Jan 15 13:47:29 merkur6 kernel: decode_attr_size: file size=3D43
Jan 15 13:47:29 merkur6 kernel: decode_attr_fsid: fsid=3D(0xd0878adf00f27b7=
f/0x0)
Jan 15 13:47:29 merkur6 kernel: decode_attr_fileid: fileid=3D34
Jan 15 13:47:29 merkur6 kernel: decode_attr_fs_locations: fs_locations done=
, error =3D 0
Jan 15 13:47:29 merkur6 kernel: decode_attr_mode: file mode=3D0775
Jan 15 13:47:29 merkur6 kernel: decode_attr_nlink: nlink=3D42
Jan 15 13:47:29 merkur6 kernel: decode_attr_owner: uid=3D65534
...skipping...
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:29 merkur6 kernel: NFS: dentry_delete(/-, 8084c)
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:45/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/anzeigen) =
is valid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:43/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/2024) is v=
alid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:75/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:47:31 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 59
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:00 merkur6 CRON[3797168]: pam_unix(cron:session): session clos=
ed for user root
Jan 15 13:48:00 merkur6 CRON[3797195]: pam_unix(cron:session): session open=
ed for user root(uid=3D0) by (uid=3D0)
Jan 15 13:48:00 merkur6 CRON[3797196]: (root) CMD (/usr/libexec/zabbix-exte=
nsions/scripts/iostat-collect.sh /tmp/iostat-cron.out 59 >/dev/null 2>&1)
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:01 merkur6 kernel: encode_sequence: sessionid=3D1701864457:319=
8674332:283960:0 seqid=3D279 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:01 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:06 merkur6 kernel: encode_sequence: sessionid=3D1686681223:197=
2710396:429668:0 seqid=3D261857 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:06 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
...skipping...
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:29 merkur6 kernel: NFS: dentry_delete(/-, 8084c)
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:45/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/anzeigen) =
is valid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:43/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/2024) is v=
alid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:75/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:47:31 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 59
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:00 merkur6 CRON[3797168]: pam_unix(cron:session): session clos=
ed for user root
Jan 15 13:48:00 merkur6 CRON[3797195]: pam_unix(cron:session): session open=
ed for user root(uid=3D0) by (uid=3D0)
Jan 15 13:48:00 merkur6 CRON[3797196]: (root) CMD (/usr/libexec/zabbix-exte=
nsions/scripts/iostat-collect.sh /tmp/iostat-cron.out 59 >/dev/null 2>&1)
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:01 merkur6 kernel: encode_sequence: sessionid=3D1701864457:319=
8674332:283960:0 seqid=3D279 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:01 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:06 merkur6 kernel: encode_sequence: sessionid=3D1686681223:197=
2710396:429668:0 seqid=3D261857 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:06 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
...skipping...
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:29 merkur6 kernel: NFS: dentry_delete(/-, 8084c)
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:45/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/anzeigen) =
is valid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:43/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/2024) is v=
alid
Jan 15 13:47:29 merkur6 kernel: NFS: permission(0:75/34), mask=3D0x81, res=
=3D0
Jan 15 13:47:29 merkur6 kernel: NFS: nfs_lookup_revalidate_done(/-) is vali=
d
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:47:31 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 59
Jan 15 13:47:31 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:00 merkur6 CRON[3797168]: pam_unix(cron:session): session clos=
ed for user root
Jan 15 13:48:00 merkur6 CRON[3797195]: pam_unix(cron:session): session open=
ed for user root(uid=3D0) by (uid=3D0)
Jan 15 13:48:00 merkur6 CRON[3797196]: (root) CMD (/usr/libexec/zabbix-exte=
nsions/scripts/iostat-collect.sh /tmp/iostat-cron.out 59 >/dev/null 2>&1)
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:01 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:01 merkur6 kernel: encode_sequence: sessionid=3D1701864457:319=
8674332:283960:0 seqid=3D279 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:01 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:01 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:01 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:01 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:01 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:01 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: start
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_proc_async_sequence status=3D0
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0000 highe=
st_used=3D4294967295 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 slotid=3D0
Jan 15 13:48:06 merkur6 kernel: encode_sequence: sessionid=3D1686681223:197=
2710396:429668:0 seqid=3D261857 slotid=3D0 max_slotid=3D0 cache_this=3D0
Jan 15 13:48:06 merkur6 kernel: nfs4_renew_state: done
Jan 15 13:48:06 merkur6 kernel: --> nfs4_alloc_slot used_slots=3D0001 highe=
st_used=3D0 max_slots=3D30
Jan 15 13:48:06 merkur6 kernel: <-- nfs4_alloc_slot used_slots=3D0003 highe=
st_used=3D1 slotid=3D1
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 1 highest_used_sloti=
d 0
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_process: Error 0 free the sl=
ot
Jan 15 13:48:06 merkur6 kernel: nfs4_free_slot: slotid 0 highest_used_sloti=
d 4294967295
Jan 15 13:48:06 merkur6 kernel: nfs41_sequence_call_done rpc_cred 000000006=
b5e23dc
Jan 15 13:48:06 merkur6 kernel: <-- nfs41_sequence_call_done
Jan 15 13:48:06 merkur6 kernel: nfs4_schedule_state_renewal: requeueing wor=
k. Lease period =3D 60

I hope this bug report is okay.

Regards=20
Sebastian

